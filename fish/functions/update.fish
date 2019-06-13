function update
  brew upgrade;
  brew cleanup;
  asdf update;
  fisher self-update;
  fisher;
end
