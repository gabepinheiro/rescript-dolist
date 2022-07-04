open Ancestor.Default

open Render

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
  <Box width=[xs(100.0->#pct)] height=[xs(100.0->#pct)] bgColor=[xs(Theme.Colors.black)]>
    <Button> {"Adicionar"} </Button>
    //
    <Checkbox />
    //
    <Input placeholder="Nova tarefa" />
  </Box>
}
