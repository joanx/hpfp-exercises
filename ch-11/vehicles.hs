-- Intermediate exercise: Vehicles
module Vehicles where

import Data.Char

data Vehicle = Car Manufacturer Price | Plane Airline deriving (Eq, Show)
data Manufacturer =  Mini | Mazda | Tata deriving (Eq, Show)
data Price = Price Integer deriving (Eq, Show)
data Airline = PapuAir deriving (Eq, Show)

myCar :: Vehicle
myCar = Car Mini (Price 14000)

urCar :: Vehicle
urCar = Car Mazda (Price 20000)

clownCar :: Vehicle
clownCar = Car Tata (Price 7000)

doge :: Vehicle
doge = Plane PapuAir

isCar :: Vehicle -> Bool
isCar vehicle =
  case vehicle of
    Car{} -> True
    _ -> False

isPlane :: Vehicle -> Bool
isPlane vehicle =
  case vehicle of
    Plane{} -> True
    _ -> False

areCars :: [Vehicle] -> [Bool]
areCars = map isCar

getManu :: Vehicle -> Manufacturer
getManu vehicle =
  case vehicle of
    Car m _ -> m
    otherwise -> error "Not a car"
