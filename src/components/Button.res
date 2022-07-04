open Render

module Styles = {
  open Emotion

  let {toString: colorToString} = module(Theme.Colors)

  let button = css({
    "border": 0,
    "outline": 0,
    "backgroundColor": Theme.Colors.primary->colorToString,
    "color": Theme.Colors.white->colorToString,
    "height": "3.8rem",
    "minWidth": "10.5rem",
    "borderRadius": "6px",
    "fontSize": "1.6rem",
    "lineHeight": "2.1rem",
    "letterSpacing": "-0.035rem",
    "cursor": "pointer",
    "transition": "300ms",
    "&:hover": {
      "backgroundColor": Theme.Colors.primaryDark->colorToString,
    },
  })
}

@react.component
let make = (~children, ~onClick=?) => {
  <button className=Styles.button ?onClick> {children->s} </button>
}
