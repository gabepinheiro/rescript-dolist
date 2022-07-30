module Styles = {
  open Emotion

  let {toString: colorToString} = module(Theme.Colors)

  let input = css({
    "color": Theme.Colors.white->colorToString,
    "fontSize": "1.8rem",
    "border": 0,
    "padding": "1.6rem 1.6rem",
    "borderRadius": "6px",
    "outline": 0,
    "width": "100%",
    "background": Theme.Colors.grayDark->colorToString,
    "transition": "300ms",
    "&:placeholder": {
      "color": Theme.Colors.grayLight->colorToString,
    },
    "&:focus": {
      "transition": "300ms",
      "boxShadow": `0px 0px 0px 2px ${Theme.Colors.primary->colorToString}`,
    },
  })
}

@react.component
let make = (~onChange=?, ~name=?, ~placeholder=?) => {
  <input className=Styles.input ?onChange ?name ?placeholder />
}
