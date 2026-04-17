from typing import Optional, Union, List, Dict
from langgraph.graph import StateGraph, END
from state import AgentState
from agents import (
    router_node,
    sql_generator_node,
    execute_sql_node,
    error_agent_node,
    data_analyst_node,
    general_assistant_node,
    visualization_node,
    out_of_scope_node
)

def build_graph():
    workflow = StateGraph(AgentState)
    
    # Add nodes
    workflow.add_node("router", router_node)
    
    # SQL Flow nodes
    workflow.add_node("sql_generator", sql_generator_node)
    workflow.add_node("execute_sql", execute_sql_node)
    workflow.add_node("error_agent", error_agent_node)
    workflow.add_node("data_analyst", data_analyst_node)
    workflow.add_node("visualization", visualization_node)
    
    # Alternative flow nodes
    workflow.add_node("general_assistant", general_assistant_node)
    workflow.add_node("out_of_scope", out_of_scope_node)
    
    # Set entry point
    workflow.set_entry_point("router")
    
    # Define routing logic from Router
    def route_from_router(state: AgentState):
        if state["next_node"] == "sql_generator":
            return "sql_generator"
        elif state["next_node"] == "general_assistant":
            return "general_assistant"
        else:
            return "out_of_scope"
            
    # Define routing logic from Execution (Handling Errors)
    def route_execution(state: AgentState):
        if state["error"]:
            if state["iteration_count"] < 3:
                return "error_agent"
            else:
                return "data_analyst" # Fail gracefully, let analyst explain failure
        return "data_analyst"
        
    # Add Router edges
    workflow.add_conditional_edges(
        "router", 
        route_from_router,
        {
            "sql_generator": "sql_generator",
            "general_assistant": "general_assistant",
            "out_of_scope": "out_of_scope"
        }
    )
    
    # Add SQL Flow edges
    workflow.add_edge("sql_generator", "execute_sql")
    workflow.add_conditional_edges(
        "execute_sql", 
        route_execution,
        {
            "error_agent": "error_agent",
            "data_analyst": "data_analyst"
        }
    )
    workflow.add_edge("error_agent", "execute_sql")
    workflow.add_edge("data_analyst", "visualization")
    workflow.add_edge("visualization", END)
    
    # Add alternative flow edges
    workflow.add_edge("general_assistant", END)
    workflow.add_edge("out_of_scope", END)
    
    return workflow.compile()

app_graph = build_graph()
