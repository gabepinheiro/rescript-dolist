open Ancestor.Default

Emotion.injectGlobal({
  "html": {
    "fontSize": "10px",
  },
  "*": {
    "margin": "0",
    "padding": "0",
  },
  "*, *::before, *::after": {
    "boxSizing": "border-box",
    "WebkitFontSmoothing": "antialiased",
    "MozOsxFontSmoothing": "grayscale",
  },
  "html, body, #root": {
    "width": "100%",
    "minHeight": "100%",
    "fontFamily": Theme.Constants.fontFamily,
  },
})

let client = ReactQuery.Provider.createClient()

@react.component
let make = () => {
  <ReactQuery.Provider client>
    <Box 
      py=[xs(4), md(9)]
      px=[xs(4), md(9)]
      width=[xs(100.0->#pct)] 
      height=[xs(100.0->#pct)] 
      bgColor=[xs(Theme.Colors.black)]
    >
        <Tasks />
    </Box>
  </ReactQuery.Provider>
}
