import Color exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Time exposing (..)
import Window

areaW =  300
areaH =  300

type alias Model = { x : Float, y : Float} 
baby = Model -(areaW/2) -10

logo = "https://raw.githubusercontent.com/drauniyar/2-5/master/firsthand/img/FirstHand_c.jpg"
umbrella = "https://raw.githubusercontent.com/drauniyar/2-5/master/firsthand/img/umbrella.gif"
babyImg = "https://raw.githubusercontent.com/drauniyar/2-5/master/firsthand/img/baby-crawl.gif"

update (timeDelta) model = model |> updatePosition timeDelta
    
updatePosition dt ({x,y} as model) = { model |x <- clamp (-(areaW/2)) ((areaW/2)-40) (x + dt), y <- clamp (-(areaW/2)) ((areaW/2)-50) (y+2*dt)}

grad =linear (0,60) (0,-60)[ (0, rgb 0 171 235), (0.79, white), (0.8, rgb 38 192 0), (1, white)]

background = circle 150 |> gradient grad 

view (w,h) {x,y} =
  let src = babyImg
  in
    container w h middle <|
    collage areaW areaH [background
        , toForm (image 100 50 logo |> opacity 0.2) |> move (0,y)
        , toForm (image 75 75 umbrella |> opacity 0.75) |> move (x-10,30)
        , toForm (image 50 50 src)|> move (x,-10)
      ]
main = Signal.map2 view Window.dimensions (Signal.foldp update baby delta) 
delta = Signal.map (\t -> t / 100) (fps 25)
