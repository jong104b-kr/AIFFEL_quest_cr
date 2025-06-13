import openai

# Set your API key here or load from environment variable
openai.api_key = "your_openai_api_key"

def grade_answer(question: str, correct_answer: str, student_answer: str) -> dict:
    prompt = f"""
You are an expert grader for the Electrical Industry Engineer Practical Exam.
Grade the student's short answer.

Question:
{question}

Correct Answer:
{correct_answer}

Student Answer:
{student_answer}

Provide a score from 0 to 10 and a short feedback (in Korean).

Format:
Score: <score>
Feedback: <feedback>
"""

    response = openai.ChatCompletion.create(
        model="gpt-4",
        messages=[{"role": "user", "content": prompt}],
        temperature=0.2,
    )

    content = response.choices[0].message['content']
    
    try:
        score_line, feedback_line = content.strip().split("\n", 1)
        score = float(score_line.replace("Score:", "").strip())
        feedback = feedback_line.replace("Feedback:", "").strip()
    except:
        score = 0.0
        feedback = "Failed to parse response."

    return {"score": score, "feedback": feedback}