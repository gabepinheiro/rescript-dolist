open Ancestor.Default
open Render

module Styles = {
  open Emotion

  let {toString: colorToString} = module(Theme.Colors)

  let button = (~disabled) => css({
    "display": "flex",
    "alignItems": "center",
    "justifyContent": "center",
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
    "cursor": disabled ? "not-allowed" : "pointer",
    "transition": "300ms",
    "opacity": disabled ? "0.5" : "1",
    "&:hover": {
      "backgroundColor": Theme.Colors.primaryDark->colorToString,
    },
  })
}

@react.component
let make = (~children, ~onClick=?, ~loading=false, ~disabled=false) => {
  <button 
    className=Styles.button(~disabled) 
    disabled
    ?onClick
  > 

    {switch loading {
    | true => <Base tag=#img src=Assets.spinnerSvg width=[xs(2.4->#rem)] />
    | false => {children->s}
    }} 
  </button>
}
