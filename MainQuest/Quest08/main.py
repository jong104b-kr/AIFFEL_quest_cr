from fastapi import FastAPI
from pydantic import BaseModel
from grading import grade_answer

app = FastAPI()

class GradeRequest(BaseModel):
    student_answer: str
    correct_answer: str
    question: str

class GradeResponse(BaseModel):
    score: float
    feedback: str

@app.post("/grade", response_model=GradeResponse)
def grade(req: GradeRequest):
    result = grade_answer(req.question, req.correct_answer, req.student_answer)
    return result