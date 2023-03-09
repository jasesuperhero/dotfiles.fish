#!/usr/bin/env fish

function weather --description 'check the weather'
  curl wttr.in/~Berlin;
end
