#!/usr/bin/env fish

if command -qa asdf
  echo "asdf installed. Everyting is fine"
else
  echo "There is no asdf on the machine. Installing..."
  brew install asdf
end
