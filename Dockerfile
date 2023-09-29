FROM python:3.11.3-slim

#don't generage .pyc files in container
ENV PYTHONDONTWRITEBYTECODE=1

# turn off buffering for better container logging
ENV PYTHONUNBUFFERED=1

ENV path /home/${username}/.local/bin:$PATH

# install pipenv
COPY Pipfile Pipfile.lock ./
RUN pip install pipenv 
RUN pipenv install --system --deploy
RUN pipenv install --dev --system --deploy

WORKDIR /var/www
COPY . .
RUN pipenv sync
EXPOSE 8080
CMD [ "uvicorn", "src.app:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "8080" ]