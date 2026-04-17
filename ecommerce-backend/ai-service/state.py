from typing import Optional, Union, List, Dict, Any, Sequence, Annotated
from typing_extensions import TypedDict
import operator
from langchain_core.messages import BaseMessage

class AgentState(TypedDict):
    """
    Represents the state of our multi-agent system.
    """
    # Context variables
    user_role: str
    user_id: int
    question: str
    
    # State routing & logic
    next_node: str # Determined by router: "sql_generator", "general_assistant", "out_of_scope"
    error: Optional[str]
    iteration_count: int
    
    # Payload vars
    sql_query: Optional[str]
    query_result: Optional[List[Dict[str, Any]]]
    
    # Final Output
    final_answer: Optional[str]
    visualization_code: Optional[str] # JSON string of Plotly figure

