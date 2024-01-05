#!/bin/bash
# Install python and pip if they are not installed
if ! [ -x "$(command -v python3)" ]; then
  echo 'Installing python'
  brew install python3
fi

# Install litellm by pip if it is not installed
if ! [ -x "$(command -v litellm)" ]; then
  echo 'Installing litellm using pip'
  pip3 install litellm
fi

# Install ollama when it is not installed using brew
if ! [ -x "$(command -v ollama)" ]; then
  echo 'Installing ollama using brew'
  brew install ollama
fi

# pull codellama model if it's not already there
ollama pull codellama


# Start the ollama server in a new window
(ollama serve &)

# Wait for the server to start listening on port 11434
while ! nc -z localhost 11434; do sleep 0.1; done

# Run the litellm command in the current window
litellm --config ./config.yaml