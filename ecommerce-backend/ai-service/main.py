from typing import Optional
from fastapi import FastAPI
from pydantic import BaseModel
from graph import app_graph
import uvicorn

app = FastAPI(title="E-Commerce AI Agentic Service")

class ChatRequest(BaseModel):
    question: str
    userRole: str
    userId: int

class ChatResponse(BaseModel):
    answer: str
    visualizationCode: Optional[str] = None
    visualizationType: Optional[str] = None
    isError: bool = False

@app.post("/chat", response_model=ChatResponse)
async def chat_endpoint(request: ChatRequest):
    initial_state = {
        "question": request.question,
        "user_role": request.userRole,
        "user_id": request.userId,
        "iteration_count": 0,
        "error": None,
        "query_result": None,
        "final_answer": None,
        "visualization_code": None,
        "sql_query": None,
        "next_node": ""
    }
    
    try:
        final_state = app_graph.invoke(initial_state)
            
        if final_state.get("error") and final_state.get("iteration_count") >= 3:
            return ChatResponse(
                answer="I'm sorry, I couldn't generate a valid query to fetch the requested data.",
                isError=True
            )
            
        return ChatResponse(
            answer=final_state.get("final_answer", "No analysis could be generated."),
            visualizationCode=final_state.get("visualization_code"),
            isError=False
        )
        
    except Exception as e:
        return ChatResponse(
            answer=f"An internal error occurred: {str(e)}",
            isError=True
        )

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
