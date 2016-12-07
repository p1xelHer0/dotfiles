module.exports = {
  config: {
    // default font size in pixels for all tabs
    fontSize: 12,

    // font family with optional fallbacks
    fontFamily: '"Fira Code", "DejaVu Sans Mono", "Lucida Console", monospace',

    // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
    cursorShape: 'BLOCK',

    // custom css to embed in the main window
    css: '',

    // custom css to embed in the terminal window
    termCSS: '',

    // custom padding (css format, i.e.: `top right bottom left`)
    padding: '4px 6px',

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    shell: '',

    // for setting shell arguments (i.e. for using interactive shellArgs: ['-i'])
    // by default ['--login'] will be used
    shellArgs: ['--login'],

    // for environment variables
    env: {},

    // set to false for no bell
    bell: 'SOUND',

    // if true, selected text will automatically be copied to the clipboard
    copyOnSelect: false,

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // for advanced config flags please refer to https://hyper.is/#cfg

    // plugin configs
    hyperline: {
      background: 'transparent',
      color: 'black',
      plugins: [
        /* {
          name: 'hostname',
          options: {
            color: 'lightBlue'
          }
        }, */
        {
          name: 'memory',
          options: {
            color: 'blue'
          }
        },
        {
          name: 'uptime',
          options: {
            color: 'magenta'
          }
        },
        {
          name: 'cpu',
          options: {
            colors: {
              high: 'red',
              moderate: 'yellow',
              low: 'green'
            }
          }
        },
        {
          name: 'network',
          options: {
            color: 'lightCyan'
          }
        },
        {
          name: 'battery',
          options: {
            colors: {
              fine: 'lightGreen',
              critical: 'lightRed'
            }
          }
        }
      ]
    },

    installDevTools: {
      extensions: [
        'REACT_DEVELOPER_TOOLS',
        'REDUX_DEVTOOLS'
      ],
      forceDownload: false
    }
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [
    'hyper-blink',                // blinking cursor
    'hypercwd',                   // open tabs/panes in cwd
    // 'hyperline',                  // bottom status bar
    'hyperterm-cursor',           // transparent cursor
    'hyperterm-install-devtools', // devtools
    'hyper-p1xelher0',            // theme
    'hyperterm-paste',            // safe copy-pasting
    'hyperterm-themed-scrollbar'  // scorllbar that looks good
  ],

  // in development, you can create a directory under
  // `$HOME/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: []
};
