FROM python:3.11.3-slim

#don't generage .pyc files in container
ENV PYTHONDONTWRITEBYTECODE=1

# turn off buffering for better container logging
ENV PYTHONUNBUFFERED=1

# install pipenv
COPY Pipfile Pipfile.lock ./
RUN python -m pip install --upgrade pip
RUN pip install pipenv && pipenv install --dev --system --deploy

WORKDIR /src
COPY . .
RUN pipenv sync
EXPOSE 8080
CMD [ "pipenv", "run", "python", "app.py" ]