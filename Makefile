activate:
	conda activate fastapi
runserver:
	cd server; uvicorn main:app --reload