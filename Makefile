activate:
	conda activate fastapi
runserver:
	cd server; uvicorn main:app --reload
seed:
	cd server; python seed_data.py