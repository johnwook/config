function update
  brew upgrade;
  brew cleanup;
  asdf update;
  asdf plugin-update --all;
  fisher self-update;
  fisher;
  rustup update;
end
