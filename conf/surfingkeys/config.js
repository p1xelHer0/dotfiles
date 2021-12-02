
mapkey("<Ctrl-y>", "Show me the money", function () {
  Front.showPopup(
    "a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close)."
  );
});

settings.theme = `
  .sk_theme {
    font-family: "JetBrains Mono Medium", "JetBrainsMonoMedium Nerd Font";
    background: #24272e;
    color: #abb2bf;
  }

  .sk_theme tbody {
    color: #fff;
  }

  .sk_theme input {
    color: #d0d0d0;
  }

  .sk_theme .url {
    color: #61afef;
  }

  .sk_theme .annotation {
    color: #56b6c2;
  }

  .sk_theme .omnibar_highlight {
    color: #528bff;
  }

  .sk_theme .omnibar_timestamp {
    color: #e5c07b;
  }

  .sk_theme .omnibar_visitcount {
    color: #98c379;
  }

  .sk_theme #sk_omnibarSearchResult>ul>li:nth-child(odd) {
    background: #303030;
  }

  .sk_theme #sk_omnibarSearchResult>ul>li.focused {
    background: #3e4452;
  }

  #sk_status, #sk_find {
    font-size: 24px;
  }
`;

