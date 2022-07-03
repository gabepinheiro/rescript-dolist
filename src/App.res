open Ancestor.Default

open Render

@react.component
let make = () => {
  <Box bgColor=[xs(#hex("#000")), md(#hex("#cacaca"))]>
    <Typography tag=#h2 color=[xs(#hex("#fff")), md(#hex("#000"))]>
      {`Hello from ReScript and Vite 😄`->s}
    </Typography>
  </Box>
}
