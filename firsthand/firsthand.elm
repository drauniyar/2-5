import Color exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Time exposing (..)
import Window
import Markdown

areaW =  400
areaH =  320

type alias Model = { x : Float, y : Float} 
baby = Model -200 -10

message = "Improving Children's quality of Life today and <br/>creating healthier communities for tomorrow"
logo = "https://www.firsthandfoundation.org/wp-content/uploads/2015/03/FirstHand_c.jpg"
umbrella = "http://ed101.bu.edu/StudentDoc/Archives/ED101sp06/ktlee/umbrella.gif"
babyImg = "http://marketingworks.net/wp-content/themes/marketingworks/assets/images/baby-crawl.gif"

update (timeDelta) model = model |> updatePosition timeDelta
    
updatePosition dt ({x,y} as model) = { model |x <- clamp (-200) (100) (x + dt)}

grad =linear (0,60) (0,-60)[ (0, rgb 0 171 235), (0.79, white), (0.8, rgb 38 192 0), (1, white)]

background = rect 400 320|> gradient grad 

view (w,h) {x,y} =
  let src = babyImg
  in
    container w h middle <|
    collage areaW areaH [background
        , toForm (Markdown.toElement message) |> moveY(130)
        , toForm (image 100 50 logo |> opacity 0.5) |> move (100,80)
        , toForm (image 75 75 umbrella |> opacity 0.75) |> move (x-10,30)
        , toForm (image 50 50 src)|> move (x,-10)
      ]
main = Signal.map2 view Window.dimensions (Signal.foldp update baby delta) 
delta = Signal.map (\t -> t / 100) (fps 25)
