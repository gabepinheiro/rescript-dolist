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
    "height": "100%",
    "fontFamily": Theme.Constants.fontFamily,
  },
})

@react.component
let make = () => {
  <Box 
    py=[xs(4), md(9)]
    px=[xs(4), md(9)]
    width=[xs(100.0->#pct)] 
    height=[xs(100.0->#pct)] 
    bgColor=[xs(Theme.Colors.black)]
  >
      <Tasks />
  </Box>
}
