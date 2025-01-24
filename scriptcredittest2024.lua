ac.storageSetPath('acs_x86', nil)

local cartemp = {0, 0, 0}
local cartempgoal = {0, 0, 0}
local carhardfactor = {0, 0, 0}

local sim = ac.getSim()

local engineFile = ac.INIConfig.carData(0, "engine.ini")
local cylinders = engineFile:get("COOLING","CYLINDERS",0)
local coolingScore = engineFile:get("COOLING","COOLING_SCORE",0)

local carFile = ac.INIConfig.carData(0, "car.ini")
local hasRollcage = 0
local safetyRating = 0

local counter = 0
local waterAdjuster = 0

local gforces = 0
local blown = 0

local died = 0

local fuel = 10
local oilAmount = 100
local oilQuality = 100
local oilColor

-- good rgbm(0.35,0.3,0,0.8)

local collisionTimer = os.clock()
local loadCheck = false
local loadCheckTimer = os.clock()
local coords = vec3()
local orientation = vec3()
local justteleported = false
local teleporttimer = os.clock()
local teleportToPits = false
local mapAdvance = false
local coordLoadingTimer = os.clock()
local coordLoadCheck = false

local trackType = 0

local carPosition = vec3(0, 0, 0)
local carOrientation = vec3(0, 0, 0)

local mapType = 0

local locationSecret = false
local locationSecretNumber = 0
local locationSecretTimer = os.clock()
local location0 = false
local location1 = false
local location2 = false
local location3 = false
local location4 = false
local location5 = false
local location6 = false
local location7 = false
local location8 = false
local location9 = false
local location10 = false
local location11 = false
local location12 = false
local location13 = false
local location14 = false
local location15 = false
local location16 = false
local location17 = false
local location18 = false
local location19 = false
local secretReward = 1

local storedValues = ac.storage{
	died = 0,
    fuel = 10,
    mapType = 0,
    map0 = '',
    carPositionMap0X = 0,
    carPositionMap0Y = 0,
    carPositionMap0Z = 0,
    carOrientationMap0X = 0,
    carOrientationMap0Y = 0,
    carOrientationMap0Z = 0,
    map1 = '',
    carPositionMap1X = 0,
    carPositionMap1Y = 0,
    carPositionMap1Z = 0,
    carOrientationMap1X = 0,
    carOrientationMap1Y = 0,
    carOrientationMap1Z = 0,
    mapPort = 0,
    calledTow = 0,
    carDamage0 = 0,
    carDamage1 = 0,
    carDamage2 = 0,
    carDamage3 = 0,
    engineDamage = 1000,
    oilAmount = 100,
    oilQuality = 100,
    locationSecretNumber = 0,
    location0 = false,
    location1 = false,
    location2 = false,
    location3 = false,
    location4 = false,
    location5 = false,
    location6 = false,
    location7 = false,
    location8 = false,
    location9 = false,
    location10 = false,
    location11 = false,
    location12 = false,
    location13 = false,
    location14 = false,
    location15 = false,
    location16 = false,
    location17 = false,
    location18 = false,
    location19 = false,
    secretReward = 1
}

local fpsClock = os.clock()
local initialLaunch = false


--- CAR ARRAY KEY ---
--- 
--- NAME, TRANSMISSION, LOW PRICE, HIGH PRICE, RARITY, SKIN AMOUNT, SKIN NAME, SKIN RARITY
--- 
--- production number key - amount to put in
--- less than 50 - 1; 100 - 2; 1,000 - 5; 5,000 - 10; 10,000 - 20; 20,000 - 30; 50,000 - 40; 100,000 - 60; 500,000 - 80; over 1,000,000 - 100

local carArray = {

--- HONDA ---

{'1995 Honda Acty SDX (HA3)', 'Manual', 1000, 5000, 30, 2, 'Tahuta White', 95, 'Bay Blue', 5},
{'1995 Honda Acty SDX (HA3)', 'Automatic', 1000, 5000, 7, 2, 'Tahuta White', 95, 'Bay Blue', 5},
{'1995 Honda Acty STD (HA3)', 'Manual', 1000, 5000, 7, 2, 'Tahuta White', 95, 'Bay Blue', 5},
{'1995 Honda Acty SDX (HA4)', 'Manual', 1000, 5000, 30, 2, 'Tahuta White', 95, 'Bay Blue', 5},

{'1995 Honda Integra SIR-G (DC2)', 'Manual', 8000, 20000, 22, 8, 'Frost White', 17, 'Vogue Silver Metallic', 5, 'Starlight Black Pearl', 27, 'Milano Red', 29, 'Matador Red Pearl', 2, 'Cypress Green Pearl', 12, 'Adriatic Blue Pearl', 4, 'Dark Currant Pearl', 2},
{'1995 Honda Integra SIR-G (DC2)', 'Automatic', 6000, 15000, 7, 8, 'Frost White', 17, 'Vogue Silver Metallic', 5, 'Starlight Black Pearl', 27, 'Milano Red', 29, 'Matador Red Pearl', 2, 'Cypress Green Pearl', 12, 'Adriatic Blue Pearl', 4, 'Dark Currant Pearl', 2},
{'1995 Honda Integra Type R (DC2)', 'Manual', 10000, 40000, 18, 4, 'Championship White [Black Recaro Seats]', 40, 'Milano Red [Black Recaro Seats]', 10, 'Championship White [Red Recaro Seats]', 40, 'Milano Red [Red Recaro Seats]', 10},
{'1995 Honda Integra Type R (DC2) [Safety Package]', 'Manual', 20000, 50000, 5, 4, 'Championship White [Black Recaro Seats]', 40, 'Milano Red [Black Recaro Seats]', 10, 'Championship White [Red Recaro Seats]', 40, 'Milano Red [Red Recaro Seats]', 10},
{'1998 Honda Integra SIR-G (DC2)', 'Manual', 8000, 20000, 18, 9, 'Frost White', 17, 'Vogue Silver Metallic', 5, 'Lightning Silver Metallic', 3, 'Starlight Black Pearl', 26, 'Milano Red', 30, 'Burning Red Pearl', 3, 'Cypress Green Pearl', 12, 'Super Sonic Blue Pearl', 3, 'Adriatic Blue Pearl', 3},
{'1998 Honda Integra SIR-G (DC2)', 'Automatic', 6000, 15000, 6, 9, 'Frost White', 17, 'Vogue Silver Metallic', 5, 'Lightning Silver Metallic', 3, 'Starlight Black Pearl', 26, 'Milano Red', 30, 'Burning Red Pearl', 3, 'Cypress Green Pearl', 12, 'Super Sonic Blue Pearl', 3, 'Adriatic Blue Pearl', 3},
{'1998 Honda Integra Type R (DC2)', 'Manual', 15000, 50000, 9, 8, 'Championship White [Black Recaro Seats]', 41, 'Vogue Silver Metallic [Black Recaro Seats]', 3, 'Starlight Black Pearl [Black Recaro Seats]', 3, 'Milano Red [Black Recaro Seats]', 3, 'Championship White [Red Recaro Seats]', 41, 'Vogue Silver Metallic [Red Recaro Seats]', 3, 'Starlight Black Pearl [Red Recaro Seats]', 3, 'Milano Red [Red Recaro Seats]', 3},
{'1998 Honda Integra Type R (DC2) [Safety Package]', 'Manual', 20000, 50000, 6, 8, 'Championship White [Black Recaro Seats]', 41, 'Vogue Silver Metallic [Black Recaro Seats]', 3, 'Starlight Black Pearl [Black Recaro Seats]', 3, 'Milano Red [Black Recaro Seats]', 3, 'Championship White [Red Recaro Seats]', 41, 'Vogue Silver Metallic [Red Recaro Seats]', 3, 'Starlight Black Pearl [Red Recaro Seats]', 3, 'Milano Red [Red Recaro Seats]', 3},
{'2000 Honda Integra Type R (DC2)', 'Manual', 20000, 40000, 7, 10, 'Championship White [Black Recaro Seats]', 40, 'Vogue Silver Metallic [Black Recaro Seats]', 2, 'Starlight Black Pearl [Black Recaro Seats]', 2, 'Milano Red [Black Recaro Seats]', 2, 'Sunlight Yellow [Black Recaro Seats]', 2, 'Championship White [Red Recaro Seats]', 40, 'Vogue Silver Metallic [Red Recaro Seats]', 2, 'Starlight Black Pearl [Red Recaro Seats]', 2, 'Milano Red [Red Recaro Seats]', 2, 'Sunlight Yellow [Yellow Recaro Seats]', 2},
{'2000 Honda Integra Type R X (DC2)', 'Manual', 15000, 40000, 6, 10, 'Championship White [Black Recaro Seats]', 40, 'Vogue Silver Metallic [Black Recaro Seats]', 2, 'Starlight Black Pearl [Black Recaro Seats]', 2, 'Milano Red [Black Recaro Seats]', 2, 'Sunlight Yellow [Black Recaro Seats]', 2, 'Championship White [Red Recaro Seats]', 40, 'Vogue Silver Metallic [Red Recaro Seats]', 2, 'Starlight Black Pearl [Red Recaro Seats]', 2, 'Milano Red [Red Recaro Seats]', 2, 'Sunlight Yellow [Yellow Recaro Seats]', 2},

--- MAZDA ---

{'1989 Eunos Roadster (NA)', 'Manual', 10000, 30000, 1, 4, 'Classic Red', 57, 'Crystal White', 24, 'Silver Stone Metallic Red', 1, 'Mariner Blue', 13},
{'1991 Eunos Roadster (NA) [Special Package]', 'Manual', 6000, 20000, 29, 4, 'Classic Red', 47, 'Crystal White', 24, 'Silver Stone Metallic Red', 12, 'Mariner Blue', 10},
{'1991 Eunos Roadster (NA)', 'Manual', 10000, 30000, 1, 4, 'Classic Red', 47, 'Crystal White', 24, 'Silver Stone Metallic Red', 12, 'Mariner Blue', 10},
{'1991 Eunos Roadster J-Limited (NA)', 'Manual', 10000, 30000, 6, 1, 'Sunburst Yellow', 1},
{'1991 Eunos Roadster (NA) [Special Package]', 'Manual', 6000, 20000, 29, 4, 'Classic Red', 47, 'Crystal White', 24, 'Silver Stone Metallic Red', 12, 'Mariner Blue', 10},
{'1991 Eunos Roadster (NA) [Special Package]', 'Automatic', 4000, 16000, 10, 4, 'Classic Red', 47, 'Crystal White', 24, 'Silver Stone Metallic Red', 12, 'Mariner Blue', 10},
{'1991 Eunos Roadster V-Special (NA)', 'Manual', 6000, 25000, 18, 2, 'British Racing Green', 40, 'Brilliant Black', 60},
{'1995 Eunos Roadster (NA) [Special Package]', 'Manual', 8000, 25000, 20, 4, 'Classic Red', 48, 'Chaste White', 48, 'Silver Stone Metallic Red', 14, 'Brilliant Black', 29},
{'1995 Eunos Roadster (NA) [Special Package]', 'Automatic', 6000, 20000, 5, 4, 'Classic Red', 48, 'Chaste White', 48, 'Silver Stone Metallic Red', 14, 'Brilliant Black', 29},
{'1995 Eunos Roadster S-Special (NA)', 'Manual', 10000, 27000, 7, 3, 'Laguna Blue Metallic', 10, 'Chaste White', 55, 'Brilliant Black', 35},
{'1995 Eunos Roadster V-Special (NA)', 'Manual', 7000, 25000, 12, 3, 'Neo Green', 25, 'Chaste White', 35, 'Brilliant Black', 40},
{'1995 Eunos Roadster V-Special Type-II (NA)', 'Manual', 7000, 25000, 5, 3, 'Neo Green', 25, 'Chaste White', 35, 'Brilliant Black', 40},

{'1999 Mazda RX-7 Type R (FD)', 'Manual', 30000, 50000, 5, 5, 'Innocent Blue Mica', 41, 'Highlight Silver Metallic', 8, 'Brilliant Black', 14, 'Chaste White', 29, 'Vintage Red II', 7},
{'1999 Mazda RX-7 Type RB (FD)', 'Manual', 30000, 50000, 4, 5, 'Innocent Blue Mica', 35, 'Highlight Silver Metallic', 16, 'Brilliant Black', 15, 'Chaste White', 25, 'Vintage Red II', 9},
{'1999 Mazda RX-7 Type RB (FD)', 'Automatic', 30000, 50000, 3, 5, 'Innocent Blue Mica', 35, 'Highlight Silver Metallic', 16, 'Brilliant Black', 15, 'Chaste White', 25, 'Vintage Red II', 9},
{'1999 Mazda RX-7 Type RS (FD)', 'Manual', 35000, 60000, 7, 5, 'Innocent Blue Mica', 44, 'Highlight Silver Metallic', 9, 'Brilliant Black', 15, 'Chaste White', 24, 'Vintage Red II', 8},
{'2000 Mazda RX-7 Type RZ (FD)', 'Manual', 50000, 90000, 3, 1, 'Snow White Pearl Mica', 1},
{'2001 Mazda RX-7 Type R Bathurst R (FD)', 'Manual', 30000, 90000, 4, 3, 'Innocent Blue Mica', 30, 'Sunburst Yellow', 42, 'Pure White', 28},
{'2002 Mazda RX-7 Spirit R Type A (FD)', 'Manual', 50000, 130000, 5, 5, 'Innocent Blue Mica', 14, 'Titanium Grey', 48, 'Brilliant Black', 11, 'Pure White', 22, 'Vintage Red II', 5},
{'2002 Mazda RX-7 Spirit R Type B (FD)', 'Manual', 40000, 80000, 3, 5, 'Innocent Blue Mica', 15, 'Titanium Grey', 48, 'Brilliant Black', 13, 'Pure White', 19, 'Vintage Red II', 6},
{'2002 Mazda RX-7 Spirit R Type C (FD)', 'Automatic', 25000, 45000, 1, 5, 'Innocent Blue Mica', 18, 'Titanium Grey', 50, 'Brilliant Black', 8, 'Pure White', 23, 'Vintage Red II', 3},
{'2002 Mazda RX-7 Type R Bathurst (FD)', 'Manual', 30000, 60000, 6, 5, 'Innocent Blue Mica', 36, 'Titanium Grey', 8, 'Brilliant Black', 14, 'Pure White', 31, 'Vintage Red II', 10},

--- MITSUBISHI ---

{'1996 Mitsubishi Lancer GSR Evolution IV', 'Manual', 10000, 30000, 22, 5, 'Scotia White', 50, 'Steel Silver', 15, 'Pyrenees Black', 17, 'Palma Red', 7, 'Icecelle Blue', 15},
{'1996 Mitsubishi Lancer RS Evolution IV', 'Manual', 15000, 40000, 5, 1, 'Scotia White', 1},
{'1998 Mitsubishi Lancer GSR Evolution V', 'Manual', 20000, 40000, 13, 5, 'Scotia White', 50, 'Satellite Silver', 15, 'Pyrenees Black', 17, 'Palma Red', 7, 'Dandelion Yellow', 15},
{'1998 Mitsubishi Lancer RS Evolution V', 'Manual', 25000, 70000, 3, 1, 'Scotia White', 1},
{'1999 Mitsubishi Lancer GSR Evolution VI', 'Manual', 15000, 35000, 13, 5, 'Scotia White', 45, 'Satellite Silver', 15, 'Pyrenees Black', 15, 'Lance Blue', 10, 'Icecelle Blue', 15},
{'1999 Mitsubishi Lancer RS Evolution VI', 'Manual', 25000, 70000, 3, 1, 'Scotia White', 1},
{'2000 Mitsubishi Lancer GSR Evolution VI Tommi Makinen Edition', 'Manual', 30000, 80000, 7, 5, 'Scotia White', 47, 'Satellite Silver', 17, 'Pyrenees Black', 10, 'Canal Blue', 19, 'Passion Red', 6},
{'2000 Mitsubishi Lancer GSR Evolution VI Tommi Makinen Edition Special Color Package', 'Manual', 40000, 220000, 3, 1, 'Passion Red', 1},
{'2000 Mitsubishi Lancer RS Evolution VI Tommi Makinen Edition', 'Manual', 25000, 70000, 2, 1, 'Scotia White', 1},

{'2005 Mitsubishi Lancer Evolution IX GSR', 'Manual', 20000, 50000, 9, 6, 'White Solid', 30, 'Yellow Solid', 4, 'Red Solid', 7, 'Blue Mica', 13, 'Black Mica', 20, 'Cool Silver Metallic', 26},
{'2005 Mitsubishi Lancer Evolution IX GT', 'Manual', 20000, 50000, 5, 6, 'White Solid', 38, 'Yellow Solid', 6, 'Red Solid', 10, 'Blue Mica', 12, 'Black Mica', 13, 'Cool Silver Metallic', 21},
{'2006 Mitsubishi Lancer Evolution IX MR GSR', 'Manual', 25000, 55000, 5, 4, 'White Pearl', 35, 'Cool Silver Metallic', 14, 'Medium Purplish Gray Mica', 40, 'Red Solid', 11},

--- NISSAN ---

{'1989 Nissan Skyline GTS-4 (R32)', 'Manual', 15000, 35000, 21, 9, 'Crystal White', 6, 'Black Pearl', 41, 'Red Pearl Metallic', 7, 'Light Blue Metallic', 1, 'Dark Green Metallic', 2, 'Jet Silver Metallic', 15, 'Pearl White', 2, 'Light Grey Metallic', 15, 'Dark Blue Pearl', 10},
{'1989 Nissan Skyline GTS-t Type M (R32)', 'Manual', 15000, 35000, 42, 12, 'Crystal White', 6, 'Black Pearl', 47, 'Red Pearl Metallic', 8, 'Light Blue Metallic', 1, 'Greyish Blue Pearl', 1, 'Dark Green Metallic', 1, 'Jet Silver Metallic', 16, 'Pearl White', 1, 'Yellowish Silver', 1, 'Spark Silver Metallic', 1, 'Light Grey Metallic', 11, 'Dark Blue Pearl', 10},
{'1991 Nissan Skyline GTS-4 (R32)', 'Manual', 15000, 35000, 7, 9, 'Crystal White', 10, 'Black Pearl', 23, 'Red Pearl Metallic', 8, 'Greyish Blue Pearl', 2, 'Dark Green Metallic', 2, 'Gun Grey Metallic', 38, 'Yellowish Silver', 1, 'Spark Silver Metallic', 13, 'Dark Blue Pearl', 4},
{'1991 Nissan Skyline GTS-4 (R32)', 'Automatic', 15000, 35000, 4, 9, 'Crystal White', 10, 'Black Pearl', 23, 'Red Pearl Metallic', 8, 'Greyish Blue Pearl', 2, 'Dark Green Metallic', 2, 'Gun Grey Metallic', 38, 'Yellowish Silver', 1, 'Spark Silver Metallic', 13, 'Dark Blue Pearl', 4},
{'1991 Nissan Skyline GTS-t Type M (R32)', 'Manual', 15000, 35000, 25, 8, 'Crystal White', 15, 'Black Pearl', 29, 'Red Pearl Metallic', 11, 'Greyish Blue Pearl', 1, 'Dark Green Metallic', 1, 'Gun Grey Metallic', 32, 'Spark Silver Metallic', 9, 'Dark Blue Pearl', 3},
{'1991 Nissan Skyline GTS-t Type M (R32)', 'Automatic', 15000, 35000, 12, 8, 'Crystal White', 15, 'Black Pearl', 29, 'Red Pearl Metallic', 11, 'Greyish Blue Pearl', 1, 'Dark Green Metallic', 1, 'Gun Grey Metallic', 32, 'Spark Silver Metallic', 9, 'Dark Blue Pearl', 3},
{'1991 Nissan Skyline GTS25 Type S (R32)', 'Manual', 10000, 30000, 7, 8, 'Crystal White', 6, 'Black Pearl', 23, 'Red Pearl Metallic', 9, 'Greyish Blue Pearl', 1, 'Dark Green Metallic', 2, 'Gun Grey Metallic', 42, 'Spark Silver Metallic', 14, 'Dark Blue Pearl', 3},
{'1991 Nissan Skyline GTS25 Type S (R32)', 'Automatic', 10000, 30000, 4, 8, 'Crystal White', 6, 'Black Pearl', 23, 'Red Pearl Metallic', 9, 'Greyish Blue Pearl', 1, 'Dark Green Metallic', 2, 'Gun Grey Metallic', 42, 'Spark Silver Metallic', 14, 'Dark Blue Pearl', 3},

{'1989 Nissan Skyline GT-R (R32)', 'Manual', 30000, 80000, 28, 6, 'Crystal White', 1, 'Gun Grey Metallic', 68, 'Black Pearl', 16, 'Red Pearl Metallic', 3, 'Jet Silver Metallic', 9, 'Dark Blue Pearl', 4},
{'1990 Nissan Skyline GT-R NISMO (R32)', 'Manual', 40000, 120000, 3, 1, 'Gun Grey Metallic', 1},
{'1991 Nissan Skyline GT-R (R32)', 'Manual', 30000, 80000, 21, 8, 'Crystal White', 17, 'White', 1, 'Spark Silver Metallic', 15, 'Gun Grey Metallic', 43, 'Black Pearl', 14, 'Red Pearl Metallic', 7, 'Greyish Blue Pearl', 1, 'Dark Blue Pearl', 3},
{'1991 Nissan Skyline GT-R N1 (R32)', 'Manual', 40000, 120000, 2, 1, 'Crystal White', 1},
{'1993 Nissan Skyline GT-R (R32)', 'Manual', 30000, 120000, 21, 8, 'Crystal White', 42, 'White', 1, 'Spark Silver Metallic', 22, 'Gun Grey Metallic', 19, 'Black Pearl', 9, 'Red Pearl Metallic', 7, 'Greyish Blue Pearl', 1, 'Dark Blue Pearl', 1},
{'1993 Nissan Skyline GT-R V-Spec (R32)', 'Manual', 30000, 120000, 6, 7, 'Crystal White', 28, 'Spark Silver Metallic', 33, 'Gun Grey Metallic', 22, 'Black Pearl', 9, 'Red Pearl Metallic', 5, 'Greyish Blue Pearl', 1, 'Dark Blue Pearl', 3},
{'1993 Nissan Skyline GT-R V-Spec N1 (R32)', 'Manual', 40000, 200000, 1, 1, 'Crystal White', 1},
{'1994 Nissan Skyline GT-R V-Spec II (R32)', 'Manual', 30000, 140000, 6, 5, 'Crystal White', 44, 'Spark Silver Metallic', 31, 'Gun Grey Metallic', 12, 'Black Pearl', 8, 'Red Pearl Metallic', 4},
{'1994 Nissan Skyline GT-R V-Spec II N1 (R32)', 'Manual', 80000, 280000, 1, 1, 'Crystal White', 1},

{'1995 Nissan Skyline GT-R (R33)', 'Manual', 35000, 90000, 10, 7, 'Super Clear Red', 3, 'Deep Marine Blue', 3, 'Black', 8, 'Spark Silver Metallic', 27, 'Dark Grey Pearl', 5, 'Midnight Purple', 18, 'White', 36},
{'1995 Nissan Skyline GT-R V-Spec (R33)', 'Manual', 40000, 90000, 9, 7, 'Super Clear Red', 3, 'Deep Marine Blue', 3, 'Black', 7, 'Spark Silver Metallic', 29, 'Dark Grey Pearl', 6, 'Midnight Purple', 20, 'White', 32},
{'1995 Nissan Skyline GT-R V-Spec N1 (R33)', 'Manual', 55000, 120000, 1, 1, 'White', 1},
{'1996 Nissan Skyline GT-R (R33)', 'Manual', 35000, 90000, 7, 7, 'Super Clear Red II', 2, 'Deep Marine Blue', 3, 'Black', 7, 'Dark Grey Pearl', 2, 'Sonic Silver', 24, 'Midnight Purple', 11, 'White', 50},
{'1996 Nissan Skyline GT-R LM-Limited (R33)', 'Manual', 70000, 140000, 2, 1, 'Champion Blue', 1},
{'1996 Nissan Skyline GT-R V-Spec (R33)', 'Manual', 40000, 90000, 5, 7, 'Super Clear Red II', 3, 'Deep Marine Blue', 3, 'Black', 7, 'Dark Grey Pearl', 3, 'Sonic Silver', 25, 'Midnight Purple', 15, 'White', 43},
{'1996 Nissan Skyline GT-R V-Spec LM-Limited (R33)', 'Manual', 50000, 110000, 2, 1, 'Champion Blue', 1},
{'1996 Nissan Skyline GT-R V-Spec N1 (R33)', 'Manual', 65000, 140000, 1, 1, 'White', 1},
{'1997 Nissan Skyline GT-R (R33)', 'Manual', 35000, 120000, 6, 9, 'Super Clear Red II', 2, 'Active Red', 1, 'Deep Marine Blue', 3, 'Black Pearl', 1, 'Black', 5, 'Dark Grey Pearl', 2, 'Sonic Silver', 27, 'Midnight Purple', 9, 'White', 50},
{'1997 Nissan Skyline GT-R V-Spec (R33)', 'Manual', 40000, 120000, 5, 9, 'Super Clear Red II', 3, 'Active Red', 1, 'Deep Marine Blue', 3, 'Black Pearl', 1, 'Black', 8, 'Dark Grey Pearl', 3, 'Sonic Silver', 28, 'Midnight Purple', 9, 'White', 45},
{'1997 Nissan Skyline GT-R V-Spec N1 (R33)', 'Manual', 75000, 160000, 1, 1, 'White', 1},

{'1999 Nissan Skyline GT-R (R34)', 'Manual', 80000, 180000, 7, 7, 'Active Red', 2, 'Bayside Blue', 22, 'Lightning Yellow', 1, 'Black Pearl', 13, 'Sonic Silver', 15, 'Athlete Silver', 8, 'White', 35},
{'1999 Nissan Skyline GT-R V-Spec (R34)', 'Manual', 80000, 180000, 9, 7, 'Active Red', 1, 'Bayside Blue', 28, 'Lightning Yellow', 1, 'Black Pearl', 12, 'Sonic Silver', 12, 'Athlete Silver', 5, 'White', 29},
{'1999 Nissan Skyline GT-R V-Spec N1 (R34)', 'Manual', 150000, 400000, 1, 1, 'White', 1},
{'1999 Nissan Skyline GT-R Limited Color Midnight Purple II (R34)', 'Manual', 120000, 350000, 1, 1, 'Midnight Purple II', 1},
{'1999 Nissan Skyline GT-R V-Spec Limited Color Midnight Purple II (R34)', 'Manual', 120000, 350000, 3, 1, 'Midnight Purple II', 1},
{'2000 Nissan Skyline GT-R Limited Color Midnight Purple III (R34)', 'Manual', 200000, 600000, 1, 1, 'Midnight Purple III', 1},
{'2000 Nissan Skyline GT-R V-Spec Limited Color Midnight Purple III (R34)', 'Manual', 200000, 600000, 2, 1, 'Midnight Purple III', 1},
{'2000 Nissan Skyline GT-R (R34)', 'Manual', 100000, 220000, 5, 6, 'Bayside Blue', 25, 'Black Pearl', 13, 'Athlete Silver', 2, 'White', 19, 'Pearl White', 15, 'Sparkling Silver', 25},
{'2000 Nissan Skyline GT-R V-Spec II (R34)', 'Manual', 100000, 220000, 6, 6, 'Bayside Blue', 33, 'Black Pearl', 11, 'Athlete Silver', 2, 'White', 19, 'Pearl White', 16, 'Sparkling Silver', 19},
{'2001 Nissan Skyline GT-R V-Spec II N1 (R34)', 'Manual', 200000, 550000, 1, 1, 'White', 1},
{'2001 Nissan Skyline GT-R M-Spec (R34)', 'Manual', 80000, 220000, 3, 4, 'Silica Brass', 33, 'Black Pearl', 11, 'Pearl White', 25, 'Sparkling Silver', 31},
{'2002 Nissan Skyline GT-R V-Spec II Nur (R34)', 'Manual', 200000, 500000, 4, 6, 'Millennium Jade', 22, 'Bayside Blue', 17, 'Black Pearl', 9, 'White', 22, 'Pearl White', 20, 'Sparkling Silver', 11},
{'2002 Nissan Skyline GT-R M-Spec Nur (R34)', 'Manual', 150000, 700000, 3, 5, 'Silica Brass', 3, 'Millennium Jade', 51, 'Black Pearl', 8, 'Pearl White', 26, 'Sparkling Silver', 12},

--- SUBARU ---

{'1997 Subaru Impreza Coupe Type R WRX STi Version IV (GC8)', 'Manual', 15000, 40000, 6, 3, 'Feather White', 75, 'Light Silver Metallic', 15, 'Black Mica', 10},
{'1997 Subaru Impreza Coupe Type R WRX STi Version IV V-Limited (GC8)', 'Manual', 20000, 50000, 4, 1, 'Sonic Blue Mica', 1},
{'1997 Subaru Impreza Sedan WRX (GC8)', 'Manual', 6000, 25000, 7, 5, 'Active Red', 3, 'Feather White', 52, 'Light Silver Metallic', 21, 'Black Mica', 10, 'Dark Blue Mica', 14},
{'1997 Subaru Impreza Sedan WRX STi Version IV (GC8)', 'Manual', 8000, 30000, 8, 3, 'Feather White', 66, 'Light Silver Metallic', 19, 'Black Mica', 15},
{'1997 Subaru Impreza Sedan Type RA WRX STi Version IV (GC8)', 'Manual', 20000, 40000, 3, 1, 'Feather White', 1},
{'1997 Subaru Impreza Sedan Type RA WRX STi Version IV V-Limited (GC8)', 'Manual', 10000, 40000, 4, 1, 'Sonic Blue Mica', 1},

{'1998 Subaru Impreza Coupe Type R WRX STi Version V (GC8)', 'Manual', 20000, 80000, 6, 4, 'Pure White', 50, 'Arctic Silver Metallic', 11, 'Black Mica', 10, 'Cool Grey Metallic', 29},
{'1998 Subaru Impreza Coupe Type R WRX STi Version V Limited (GC8)', 'Manual', 30000, 90000, 3, 1, 'Sonic Blue Mica', 1},
{'1998 Subaru Impreza Sedan WRX (GC8)', 'Manual', 8000, 30000, 6, 4, 'Pure White', 43, 'Arctic Silver Metallic', 18, 'Black Mica', 18, 'Cool Grey Metallic', 21},
{'1998 Subaru Impreza Sedan WRX STi Version V (GC8)', 'Manual', 10000, 40000, 7, 4, 'Pure White', 54, 'Arctic Silver Metallic', 17, 'Black Mica', 8, 'Cool Grey Metallic', 21},
{'1998 Subaru Impreza Sedan Type RA WRX STi Version V (GC8)', 'Manual', 20000, 40000, 3, 1, 'Pure White', 1},
{'1998 Subaru Impreza Sedan Type RA WRX STi Version V Limited (GC8)', 'Manual', 15000, 60000, 5, 1, 'Sonic Blue Mica', 1},

{'1999 Subaru Impreza Coupe Type R WRX STi Version VI (GC8)', 'Manual', 20000, 80000, 6, 4, 'Pure White', 50, 'Arctic Silver Metallic', 15, 'Deep Blue', 15, 'Cool Grey Metallic', 20},
{'1999 Subaru Impreza Coupe Type R WRX STi Version VI Limited (GC8)', 'Manual', 30000, 90000, 5, 1, 'Sonic Blue Mica', 1},
{'1999 Subaru Impreza Sedan WRX (GC8)', 'Manual', 8000, 30000, 4, 5, 'Pure White', 40, 'Arctic Silver Metallic', 17, 'Black Mica', 12, 'Cool Grey Metallic', 7, 'Blue Ridge Pearl', 24},
{'1999 Subaru Impreza Sedan WRX STi Version VI (GC8)', 'Manual', 10000, 40000, 6, 4, 'Pure White', 56, 'Arctic Silver Metallic', 15, 'Cool Grey Metallic', 12, 'Cashmere Yellow', 17},
{'1999 Subaru Impreza Sedan Type RA WRX STi Version VI (GC8)', 'Manual', 20000, 50000, 2, 2, 'Pure White', 79, 'Cashmere Yellow', 21},
{'1999 Subaru Impreza Sedan Type RA WRX STi Version VI Limited (GC8)', 'Manual', 15000, 60000, 6, 1, 'Sonic Blue Mica', 1},

{'2004 Subaru Impreza Sedan WRX (GDA-E)', 'Manual', 5000, 20000, 11, 6, 'WR Blue Mica', 30, 'Pure White', 17, 'Obsidian Black Pearl', 15, 'Crystal Grey Metallic', 15, 'Premium Silver Metallic', 20, 'Solid Red', 3},
{'2004 Subaru Impreza Sedan WRX (GDA-E)', 'Automatic', 5000, 20000, 4, 6, 'WR Blue Mica', 30, 'Pure White', 17, 'Obsidian Black Pearl', 15, 'Crystal Grey Metallic', 15, 'Premium Silver Metallic', 20, 'Solid Red', 3},
{'2004 Subaru Impreza Sedan WRX STi (GDB-E)', 'Manual', 10000, 30000, 1, 5, 'WR Blue Mica', 33, 'Pure White', 17, 'Obsidian Black Pearl', 15, 'Crystal Grey Metallic', 15, 'Premium Silver Metallic', 20},
{'2004 Subaru Impreza Sedan WRX STi (GDB-E) [DCCD Package]', 'Manual', 10000, 30000, 13, 5, 'WR Blue Mica', 33, 'Pure White', 17, 'Obsidian Black Pearl', 15, 'Crystal Grey Metallic', 15, 'Premium Silver Metallic', 20},

{'2015 Subaru BRZ R', 'Manual', 5000, 15000, 7, 7, 'Crystal White Pearl', 25, 'Ice Silver Metallic', 13, 'Dark Grey Metallic', 9, 'Crystal Black', 11, 'Pure Red', 11, 'World Rally Blue Pearl', 26, 'Lapis Blue Pearl', 18},
{'2015 Subaru BRZ R', 'Automatic', 5000, 15000, 7, 7, 'Crystal White Pearl', 25, 'Ice Silver Metallic', 13, 'Dark Grey Metallic', 9, 'Crystal Black', 11, 'Pure Red', 11, 'World Rally Blue Pearl', 26, 'Lapis Blue Pearl', 18},
{'2015 Subaru BRZ S', 'Manual', 10000, 20000, 7, 7, 'Crystal White Pearl', 25, 'Ice Silver Metallic', 13, 'Dark Grey Metallic', 9, 'Crystal Black', 11, 'Pure Red', 11, 'World Rally Blue Pearl', 26, 'Lapis Blue Pearl', 18},
{'2015 Subaru BRZ S', 'Automatic', 7000, 17000, 7, 7, 'Crystal White Pearl', 25, 'Ice Silver Metallic', 13, 'Dark Grey Metallic', 9, 'Crystal Black', 11, 'Pure Red', 11, 'World Rally Blue Pearl', 26, 'Lapis Blue Pearl', 18},

--- SUZUKI ---

{'1991 Suzuki Cappuccino (EA11R)', 'Manual', 4000, 20000, 23, 2, 'Cordoba Red', 75, 'Satellite Silver Metallic', 25},
{'1993 Suzuki Cappuccino (EA11R)', 'Manual', 3000, 25000, 17, 3, 'Dark Classic', 30, 'Cordoba Red', 50, 'Mercury Silver Metallic', 20},
{'1993 Suzuki Cappuccino Limited (EA11R)', 'Manual', 6000, 30000, 2, 1, 'Scuba Blue', 1},
{'1994 Suzuki Cappuccino Limited (EA11R)', 'Manual', 6000, 30000, 2, 1, 'Scuba Blue', 1},
{'1995 Suzuki Cappuccino (EA21R)', 'Manual', 5000, 25000, 8, 3, 'Dark Turquoise Green Metallic', 30, 'Antares Red', 50, 'Mercury Silver Metallic', 20},
{'1995 Suzuki Cappuccino (EA21R)', 'Automatic', 3000, 20000, 8, 3, 'Dark Turquoise Green Metallic', 30, 'Antares Red', 50, 'Mercury Silver Metallic', 20},

--- TOYOTA ---

{'1993 Toyota Supra RZ (JZA80)', 'Manual', 30000, 80000, 13, 6, 'Super White II', 25, 'Anthracite Metallic', 2, 'Silver Metallic Graphite', 33, 'Black', 24, 'Super Red IV', 14, 'Baltic Blue Metallic', 2},
{'1993 Toyota Supra SZ-R (JZA80)', 'Manual', 30000, 60000, 14, 6, 'Super White II', 25, 'Anthracite Metallic', 2, 'Silver Metallic Graphite', 33, 'Black', 24, 'Super Red IV', 14, 'Baltic Blue Metallic', 2},
{'1996 Toyota Supra RZ (JZA80)', 'Manual', 50000, 100000, 4, 6, 'Super White II', 25, 'Silver Metallic Graphite', 34, 'Black', 24, 'Super Red IV', 14, 'Deep Jewel Green', 1, 'Blue Mica Metallic', 2},
{'1996 Toyota Supra SZ-R (JZA80)', 'Manual', 30000, 60000, 5, 6, 'Super White II', 25, 'Silver Metallic Graphite', 34, 'Black', 24, 'Super Red IV', 14, 'Deep Jewel Green', 1, 'Blue Mica Metallic', 2},
{'1998 Toyota Supra RZ (JZA80)', 'Manual', 50000, 150000, 4, 7, 'Super White II', 24, 'Silver Metallic Graphite', 32, 'Black', 23, 'Super Red IV', 13, 'Super Bright Yellow', 1, 'Grayish Green Mica Metallic', 5, 'Blue Mica Metallic', 2},
{'1998 Toyota Supra SZ-R (JZA80)', 'Manual', 30000, 60000, 5, 7, 'Super White II', 24, 'Silver Metallic Graphite', 32, 'Black', 23, 'Super Red IV', 13, 'Super Bright Yellow', 1, 'Grayish Green Mica Metallic', 5, 'Blue Mica Metallic', 2},

{'2015 Toyota 86 G', 'Manual', 7000, 15000, 8, 7, 'Crystal White Pearl', 34, 'Ice Silver Metallic', 10, 'Dark Grey Metallic', 25, 'Crystal Black', 42, 'Pure Red', 11, 'Orange Metallic', 8, 'Azurite Blue Pearl', 32},
{'2015 Toyota 86 G', 'Automatic', 5000, 15000, 8, 7, 'Crystal White Pearl', 34, 'Ice Silver Metallic', 10, 'Dark Grey Metallic', 25, 'Crystal Black', 42, 'Pure Red', 11, 'Orange Metallic', 8, 'Azurite Blue Pearl', 32},
{'2015 Toyota 86 GT', 'Manual', 8000, 20000, 8, 7, 'Crystal White Pearl', 34, 'Ice Silver Metallic', 10, 'Dark Grey Metallic', 25, 'Crystal Black', 42, 'Pure Red', 11, 'Orange Metallic', 8, 'Azurite Blue Pearl', 32},
{'2015 Toyota 86 GT', 'Automatic', 7000, 20000, 8, 7, 'Crystal White Pearl', 34, 'Ice Silver Metallic', 10, 'Dark Grey Metallic', 25, 'Crystal Black', 42, 'Pure Red', 11, 'Orange Metallic', 8, 'Azurite Blue Pearl', 32},
{'2015 Toyota 86 GT \"Limited\"', 'Automatic', 10000, 20000, 8, 7, 'Crystal White Pearl', 34, 'Ice Silver Metallic', 10, 'Dark Grey Metallic', 25, 'Crystal Black', 42, 'Pure Red', 11, 'Orange Metallic', 8, 'Azurite Blue Pearl', 32},
{'2015 Toyota 86 GT \"Limited\"', 'Manual', 10000, 20000, 8, 7, 'Crystal White Pearl', 34, 'Ice Silver Metallic', 10, 'Dark Grey Metallic', 25, 'Crystal Black', 42, 'Pure Red', 11, 'Orange Metallic', 8, 'Azurite Blue Pearl', 32}

}

local carRarityTempArray = {}
local carRarityRepeatArray = 0
local carRarityAddon = 0
local carRaritySelectorRandom = math.randomseed(sim.timeSeconds)
local carRaritySelector = 0

local carSkinRarityRepeatArray = 0
local carSkinRarityTempArray = {}
local carSkinRarityAddon = 0
local carSkinAdder = 1
local carSkinRaritySelectorRandom = math.randomseed(sim.timeSeconds)
local carSkinRaritySelector = 0

local carTimeSelector = 0 --math.randomseed(sim.timeSeconds)
local carArrayTimer = os.clock()
local carPriceSelector = math.randomseed(sim.timeSeconds)

local carArrayCalculated = false
local pressedNext = false

local uiState = ac.getUI()

function DrawTextCentered(text)
    uiState = ac.getUI()
  
    ui.transparentWindow('raceText', vec2(uiState.windowSize.x / 2 - 250, uiState.windowSize.y / 2 - 250), vec2(500,100), function ()
      ui.pushFont(ui.Font.Huge)
      
      local size = ui.measureText(text)
      ui.setCursorX(ui.getCursorX() + ui.availableSpaceX() / 2 - (size.x / 2))
      ui.text(text)

      ui.text('Select point on a map:')
  
      ui.popFont()
    end)
end

local showMessageRefuel0 = false
local showMessageRefuel1 = false

local showMessageERefuel0 = false
local showMessageERefuel1 = false
local showMessageERefuel2 = false
local showMessageERefuel3 = false
local showMessageERefuelClock = os.clock()

local showMessageRepair0 = false
local showMessageRepair0S = false
local showMessageRepair1 = false

local showMessageERepair0 = false
local showMessageERepair1 = false
local showMessageERepair2 = false
local showMessageERepairClock = os.clock()

local showMessageToll0 = false
local showMessageToll1 = false
local showMessageToll2 = false
local showMessageToll3 = false
local showMessageToll4 = false
local showMessageToll5 = false
local showMessageTollClock = os.clock()

local showMessageSecrets0 = false
local showMessageSecrets1 = false
local showMessageSecrets2 = false
local showMessageSecrets = os.clock()

function Testing()
    

    if carArrayTimer + 1 < os.clock() and pressedNext then
        carRarityTempArray = {}
        carSkinRarityTempArray = {}

        for i=1, #carArray do
            carRarityRepeatArray = carArray[i][5]
            carRarityAddon = #carRarityTempArray
            for j=1, carRarityRepeatArray do
                carRarityTempArray[j + carRarityAddon] = i
            end
        end

        carRaritySelectorRandom = math.random(1, #carRarityTempArray)
        carRaritySelector = carRarityTempArray[carRaritySelectorRandom]
        carTimeSelector = carRaritySelector
        carPriceSelector = math.random(carArray[carTimeSelector] [3], carArray[carTimeSelector] [4])

        for l=1, carArray[carTimeSelector] [6] do
            carSkinRarityAddon = #carSkinRarityTempArray
            if type(carArray[carTimeSelector] [6 + (l * 2)]) == "number" then
                for m=1, carArray[carTimeSelector] [6 + (l * 2)] do
                    if l < carArray[carTimeSelector] [6] + 1 then
                        carSkinRarityTempArray[m + carSkinRarityAddon] = l
                    end
                end
            end
        end
        

        carSkinRaritySelectorRandom = math.random(1, #carSkinRarityTempArray)
        carSkinRaritySelector = carSkinRarityTempArray[carSkinRaritySelectorRandom]

        pressedNext = false
        carArrayTimer = os.clock()
    end

    if carTimeSelector ~= nil and carArray[carTimeSelector] ~= nil then
        ac.debug('CAR NAME', carArray[carTimeSelector] [1])
        ac.debug('CAR TRANSMISSION', carArray[carTimeSelector] [2])
        ac.debug('CAR PAINT', carArray[carTimeSelector] [(carSkinRaritySelector * 2) + 5])
        ac.debug('CAR PRICE', carPriceSelector)
        --ac.debug('car array maker', carRarityTempArray)
        --ac.debug('car skin array maker', carSkinRarityTempArray)
    end

    if ac.isKeyDown(32) and carArrayTimer + 1 < os.clock() then
        pressedNext = true
    end

end

local engineIsOn = true
local oilOnFire = 0
local oilTimer = os.clock()
local engineDamageTimer = os.clock()
local engineDamage = 1000
local enginedamageFirstLoad = os.clock()
local isOnFire = false
local isOnFireClock = os.clock()
local isOnFireChance = math.randomseed(sim.timeSeconds)

function LoadChecking()

    if loadCheckTimer + 1 > os.clock() then
        died = storedValues.died
        fuel = storedValues.fuel
        oilAmount = storedValues.oilAmount
        oilQuality = storedValues.oilQuality

        locationSecretNumber = storedValues.locationSecretNumber
        location0 = storedValues.location0
        location1 = storedValues.location1
        location2 = storedValues.location2
        location3 = storedValues.location3
        location4 = storedValues.location4
        location5 = storedValues.location5
        location6 = storedValues.location6
        location7 = storedValues.location7
        location8 = storedValues.location8
        location9 = storedValues.location9
        location10 = storedValues.location10
        location11 = storedValues.location11
        location12 = storedValues.location12
        location13 = storedValues.location13
        location14 = storedValues.location14
        location15 = storedValues.location15
        location16 = storedValues.location16
        location17 = storedValues.location17
        location18 = storedValues.location18
        location19 = storedValues.location19
        secretReward = storedValues.secretReward
    end

    if loadCheckTimer + 3 < os.clock() then
        fuel = storedValues.fuel
        loadCheck = true
    elseif loadCheckTimer + 2 > os.clock() and loadCheckTimer + 1 < os.clock() then
        physics.setCarFuel(0, storedValues.fuel)
        physics.setCarBodyDamage(0, vec4(storedValues.carDamage0, storedValues.carDamage1, storedValues.carDamage2, storedValues.carDamage3))
        physics.setCarEngineLife(0, storedValues.engineDamage)
        engineDamage = storedValues.engineDamage
        physics.blockTeleportingToPits()
        fuel = storedValues.fuel
    end

    if ac.getTrackID() == "kanazawa" then
        trackType = 0
    elseif ac.getTrackID() == "shuto_revival_project_beta" or ac.getTrackID() == "shuto_revival_project_beta_ptb" then
        trackType = 1
    elseif ac.getTrackID() == "ebisu_complex" then
        trackType = 2
    elseif ac.getTrackID() == "ddm_gts_tsukuba" then
        trackType = 3
    elseif ac.getTrackID() == "pk_irohazaka" then
        trackType = 4
    elseif ac.getTrackID() == "rt_fuji_speedway" then
        trackType = 5
    elseif ac.getTrackID() == "rt_suzuka" then
        trackType = 6
    end

end

local saveTimer = os.clock()

function script.update(dt)

    ac.storageSetPath('acs_x86', nil)

    Jobs()

	if loadCheck then

        if saveTimer + 1 < os.clock() then
            saveTimer = os.clock()

            storedValues.died = died
            storedValues.fuel = fuel
            storedValues.oilAmount = oilAmount
            storedValues.oilQuality = oilQuality
            storedValues.carDamage0 = car.damage[0]
            storedValues.carDamage1 = car.damage[1]
            storedValues.carDamage2 = car.damage[2]
            storedValues.carDamage3 = car.damage[3]
            if enginedamageFirstLoad + 10 > os.clock() then
                storedValues.engineDamage = engineDamage
                physics.setCarEngineLife(0, engineDamage)
            else
                storedValues.engineDamage = car.engineLifeLeft
            end

            

            storedValues.locationSecretNumber = locationSecretNumber
            storedValues.location0 = location0
            storedValues.location1 = location1
            storedValues.location2 = location2
            storedValues.location3 = location3
            storedValues.location4 = location4
            storedValues.location5 = location5
            storedValues.location6 = location6
            storedValues.location7 = location7
            storedValues.location8 = location8
            storedValues.location9 = location9
            storedValues.location10 = location10
            storedValues.location11 = location11
            storedValues.location12 = location12
            storedValues.location13 = location13
            storedValues.location14 = location14
            storedValues.location15 = location15
            storedValues.location16 = location16
            storedValues.location17 = location17
            storedValues.location18 = location18
            storedValues.location19 = location19
            storedValues.secretReward = secretReward

        end
        Fuel()
        TollManagement()
        ClosedCourses()
        SaveCarPosition()
        FindLocationsExtra()

        Testing()
        if ac.getUserSteamID() == '76561198353513861' then
            ----
        end

    elseif initialLaunch then
        LoadChecking()
    end

    if loadCheckTimer + 3 < os.clock() then
        if coordLoadCheck then
            StoredValuesLoadingCoords()
        else
            LoadCheckingCoords()
        end
    end

    if sim.fps < 10 and not initialLaunch then
        fpsClock = os.clock()
    end

    if fpsClock + 2 < os.clock() and not initialLaunch then
        loadCheckTimer = os.clock()
        coordLoadingTimer = os.clock()
        initialLaunch = true
    end

    if ac.getUserSteamID() == '76561198353513861' and ac.isKeyDown(83) and ac.isKeyDown(65) and ac.isKeyDown(77) and ac.isKeyDown(16) then
        physics.resetCarState(0, 0.5)
    end

    local car0 = ac.getCarState(0)
    local car1 = ac.getCarState(1)
    local car2 = ac.getCarState(2)

    local dataWheelLF = car.wheels[0]
    local dataWheelRF = car.wheels[1]
    local dataWheelLR = car.wheels[2]
    local dataWheelRR = car.wheels[3]

	physics.setWaterTemperature(0, car.waterTemperature - waterAdjuster)
	physics.setWaterTemperature(1, car.waterTemperature - waterAdjuster)
	physics.setWaterTemperature(2, car.waterTemperature - waterAdjuster)


    --Servers()

    if cylinders == 0 then
        os.showMessage("MISSING COOLING DATA IN \"engine.ini\"")
        ac.reconnectTo()
    end

    if carFile:get("SAFETY","SAFETY_RATING",0) == 0 then
        hasRollcage = 0
        safetyRating = 4
    else
        hasRollcage = carFile:get("SAFETY","HAS_ROLLCAGE",0)
        safetyRating = carFile:get("SAFETY","SAFETY_RATING",0)
    end

    if car1 ~= nil then

        carhardfactor[1] = car1.rpm / car1.rpmLimiter * ((car1.gas * 0.5) + 0.5) * ((4 / cylinders) * (0.75 - (coolingScore / 2)) * 10 + (car1.turboCount * car1.turboBoost / 2.5) + (math.abs(math.min(40, oilAmount) - 40) * 0.4) + (math.abs(math.min(40, oilQuality) - 40) * 0.1))
        cartempgoal[1] = car1.rpm / car1.rpmLimiter * ((car1.gas * 0.5) + 0.5) * 30 + (70 * (math.min(car1.rpm, 200) / 200))

        if cartempgoal[1] > car1.waterTemperature and car1.waterTemperature > 75 and counter < 501 then
            counter = counter + (carhardfactor[1] * 0.02)
        elseif cartempgoal[1] - 5 < car1.waterTemperature and counter > 0 then
            counter = counter - (carhardfactor[1] * 0.05)
        end

        if car1.waterTemperature > 75 and car1.waterTemperature < 78 and counter < 500 then
            waterAdjuster = waterAdjuster + (0.0001 * car1.gas) + 0.00001
        elseif car1.waterTemperature > 80 then
            waterAdjuster = (((math.max(80, (car1.waterTemperature)) - 80) * -0.0005 * car1.gas))
        elseif waterAdjuster > 1 then
            waterAdjuster = waterAdjuster - 0.3
        elseif waterAdjuster > 0 then
            waterAdjuster = waterAdjuster - 0.0001
        end

        if car1.waterTemperature > 90 or isOnFire then
            if engineDamageTimer + 0.1 < os.clock() then
                engineDamageTimer = os.clock()
                if isOnFire and car1.waterTemperature < 95 then
                    physics.setCarEngineLife(0, car.engineLifeLeft - ((95 - 90)/3))
                else
                    physics.setCarEngineLife(0, car.engineLifeLeft - ((car1.waterTemperature - 90)/3))
                end
            end
            
        end

        if car1.waterTemperature > 95 then
            isOnFireChance = math.random(0, 1000)
            if isOnFireChance == 666 then
                isOnFire = true
                isOnFireClock = os.clock()
            end
        end
        
        if car1.waterTemperature > 85 or isOnFire then
            if car.enginePosition == 2 or car.enginePosition == 3 then
                ac.Particles.Smoke({color = rgbm(0.5, 0.5, 0.5, 0.5), colorConsistency = 0.5, thickness = 0.2, life = 4, size = 0.2, spreadK = 1, growK = 1, targetYVelocity = 0}):emit(vec3((dataWheelLR.position.x + dataWheelRR.position.x) / 2, car.position.y + 1, (dataWheelLR.position.z + dataWheelRR.position.z) / 2), vec3(0,0,0), (car1.waterTemperature - 85) * 0.01)             
            else
                ac.Particles.Smoke({color = rgbm(0.5, 0.5, 0.5, 0.5), colorConsistency = 0.5, thickness = 0.2, life = 4, size = 0.2, spreadK = 1, growK = 1, targetYVelocity = 0}):emit(vec3((dataWheelLF.position.x + dataWheelRF.position.x) / 2, car.position.y + 1, (dataWheelLF.position.z + dataWheelRF.position.z) / 2), vec3(0,0,0), (car1.waterTemperature - 85) * 0.01)             
            end
        end

        if isOnFire then
            oilOnFire = 0.1
            if car.enginePosition == 2 or car.enginePosition == 3 then
                ac.Particles.Flame({color = rgbm(0.5, 0.5, 0.5, 0.5), size = 0.5, temperatureMultiplier = 2, flameIntensity = 5}):emit(vec3((dataWheelLR.position.x + dataWheelRR.position.x) / 2, car.position.y + 0.5, (dataWheelLR.position.z + dataWheelRR.position.z) / 2), vec3(0,1,0), ((isOnFireClock + 20) - os.clock()) * 0.04)
            else
                ac.Particles.Flame({color = rgbm(0.5, 0.5, 0.5, 0.5), size = 0.5, temperatureMultiplier = 2, flameIntensity = 5}):emit(vec3((dataWheelLF.position.x + dataWheelRF.position.x) / 2, car.position.y + 0.5, (dataWheelLF.position.z + dataWheelRF.position.z) / 2), vec3(0,1,0), ((isOnFireClock + 20) - os.clock()) * 0.04)    
            end

            if isOnFireClock + 20 < os.clock() then
                isOnFire = false
            end
        else
            oilOnFire = 0
        end

        ac.debug('enginedamage', car.engineLifeLeft)
        oilColor = rgbm(((oilQuality) * 0.0045 + ((car1.waterTemperature - 75)*0.001)),((oilQuality) * 0.004 + ((car1.waterTemperature - 75)*0.001)),0,0.8)

        if oilTimer + 1 < os.clock() then
            oilTimer = os.clock()
            if oilAmount > 0 and car.rpm > 100 then
                oilAmount = oilAmount - ((carhardfactor[1] * 0.0000001) + ((math.max(85, car1.waterTemperature) - 85) * 0.01) + ((400 - math.min(400,car.engineLifeLeft)) * 0.00001)) - oilOnFire
            end
            if oilAmount > 0 and oilQuality > 0 and car.rpm > 100 then
                oilQuality = oilQuality - ((carhardfactor[1] * 0.00001) + ((math.max(85, car1.waterTemperature) - 85) * 0.06) + ((400 - math.min(400,car.engineLifeLeft)) * 0.000008)) - oilOnFire
            end

            if oilAmount < 20 and car.rpm > 100 and car.engineLifeLeft > 1 then
                physics.setCarEngineLife(0, car.engineLifeLeft - (((100 - oilAmount * 5) * 0.01)))
            elseif car.engineLifeLeft < 1 then
                physics.setCarEngineLife(0, 0)
            end

            if oilAmount > 120 and car.rpm > 100 and car.engineLifeLeft > 1 then
                physics.setCarEngineLife(0, car.engineLifeLeft - (((oilAmount * 5 - 120) * 0.01)))
            elseif car.engineLifeLeft < 1 then
                physics.setCarEngineLife(0, 0)
            end

            if oilQuality < 20 and car.rpm > 100 and car.engineLifeLeft > 1 then
                physics.setCarEngineLife(0, car.engineLifeLeft - (((100 - oilQuality * 5) * 0.0001)))
            elseif car.engineLifeLeft < 1 then
                physics.setCarEngineLife(0, 0)
            end

            if car.engineLifeLeft == 0 then
                oilAmount = 0
            end

        end

        ac.debug('Oil Amount', oilAmount)
        ac.debug('Oil Quality', oilQuality)

        if car1.engineLifeLeft == 0 then
            blown = 1
        else
            blown = 0
        end

        if not engineIsOn then
            physics.setEngineStallEnabled(0, false)
            physics.setEngineRPM(0,0)
            physics.forceUserThrottleFor(1, 0)
            ac.store('turnEngineOFF',1)
        else
            if physics.setEngineStallEnabled(0, false) == false then
                physics.setEngineStallEnabled(0, true)
            end
            ac.store('turnEngineOFF',0)
        end

        ac.debug('rpm', car.rpm)
        
        ac.debug('water adjuster', waterAdjuster)
        ac.debug('temp car', cartemp[1])
        ac.debug('car counter', counter)
        ac.debug('hardfactor temp goal car', cartempgoal[1])
        ac.debug('hardfactor car', carhardfactor[1])

        if math.abs(car1.acceleration.x) + math.abs(car1.acceleration.y) + math.abs(car1.acceleration.z) > 10 * safetyRating and car.speedKmh > 50 + (safetyRating * 20) + (hasRollcage * 100) then
            ac.sendChatMessage(' has died. This is a really long message to catch everyones attention. If you want to dispute this please contact Sam with the replay to show you did not die and stuff and stuff')
        end

        if gforces < math.abs(car1.acceleration.x) + math.abs(car1.acceleration.y) + math.abs(car1.acceleration.z) then
            gforces = math.abs(car1.acceleration.x) + math.abs(car1.acceleration.y) + math.abs(car1.acceleration.z)
        end

        ac.debug('car acceleration high score', gforces)
        ac.debug('car acceleration', math.abs(car1.acceleration.x) + math.abs(car1.acceleration.y) + math.abs(car1.acceleration.z))
    else
        ac.debug('not working', 'nil')
        
    end

end

function Servers()

    local car0 = ac.getCarState(0)
    local car1 = ac.getCarState(1)
    local car2 = ac.getCarState(2)

end

local closed = false

function ClosedCourses()

    if sim.timeHours < 8 or sim.timeHours > 17 then
        closed = true
    else
        closed = false
    end

    if trackType == 2 or trackType == 3 or trackType == 5 or trackType == 6 then
        if closed then
            ac.reconnectTo({serverIP = '74.132.225.61', serverPort = 9801, serverHttpPort = 8282})
        end
    end

end

local trigListTollETCSRP = {

	-- BAYSHORE TOWARDS TATSUMI
	vec3(899.83, 6.09, -80.41),
	vec3(904.76, 6.09, -80.93),
	vec3(909.61, 6.09, -81.65),
	vec3(914.16, 6.09, -81.46),
	vec3(919.11, 6.09, -81.69),
	vec3(923.96, 6.09, -81.31),
	vec3(928.6, 6.09, -80.91),
	vec3(933.31, 6.1, -81.46),
	vec3(938.31, 6.1, -81.84),
	-- BAYHORE BEFORE KAWASAKI TUNNEL
	vec3(3992.9, -6.59, 8685.13),
	vec3(3997.05, -6.6, 8690.38),
	vec3(4002.25, -6.6, 8694.17),
	-- SHIBUYA U-TURN
	vec3(-4626.18, 41.34, -6028.49),
	vec3(-4622.25, 41.35, -6023.83),
	-- YOYOGI ETC
	vec3(-4931.34, 50.9, -9240.43),
	vec3(-4927.59, 50.83, -9237.34),
	-- HEIWAJIMA PA
	vec3(-187.8, 6, 1421.5),
	vec3(-192.95, 6, 1424.63),
	vec3(-198.33, 6, 1427.9),
	vec3(-204.08, 6, 1430.25),
	-- DAISHI PA
	vec3(-340.28,15.05,6138.03),
	vec3(-335.34,15.05,6138.96),
	-- NEW PLACE
    vec3(1594.36, 13.05, -7172.09),
    vec3(2362.11, 12.38, -8104.37),
	vec3(1475.08, 11.07, -6708.74),
	vec3(1470.97, 11.14, -6711.09),
	vec3(1466.6, 11.22, -6714.07)
}

local trigListTollETCKAZ = {

	--
	vec3(-2632.48, -122.78, 481.32),
	vec3(-2637.15, -122.8, 479.74),
	vec3(-2643.25, -123.2, 514.01),
	vec3(-2638.81, -123.16, 513.12),

	--
	vec3(-3081.17, -125.71, -4022.37),
	vec3(-3078.55, -125.71, -4026.5),
	vec3(-3373.49, -134.36, -4306.3),
	vec3(-3376.34, -134.36, -4302.7)

}

local trigListTollSRP = {

	-- BAYSHORE TOWARDS TATSUMI
	vec3(904.71, 6.13, -91.59),
	vec3(909.39, 6.14, -93.36),
	vec3(919.23, 6.13, -92.14),
	vec3(923.72, 6.14, -93.4),
	vec3(928.61, 6.14, -93.27),
	-- BAYHORE BEFORE KAWASAKI TUNNEL
	vec3(3996.28, -6.61, 8710.19),
	vec3(3991.68, -6.61, 8706.49),
    vec3(3987.17, -6.61, 8701.42),
	-- SHIBUYA U-TURN
	vec3(-4610.94, 42.13, -6032.41),
	-- YOYOGI ETC
	vec3(-4941.45, 50.83, -9224.37),
	-- HEIWAJIMA PA
	vec3(-208.59, 5.98, 1422.58),
	vec3(-204.03, 5.98, 1417.83),
	vec3(-198.22, 5.98, 1415.2),
	-- DAISHI PA
	vec3(-323.02, 15.04, 6154.19),
	vec3(-328.91, 15.03, 6154.91),
    vec3(-334.95, 15.03, 6155.22),
	-- NEW PLACE
    vec3(1790.94, 12.2, -8195.3),
    vec3(1795.36, 12.26, -8193.73),
    vec3(1791.33, 12.11, -8143.99),
    vec3(1786.76, 12.05, -8145.49),
    vec3(1583.98, 13.03, -7186.15),
    vec3(1461.54, 11.5, -6696.98),
	vec3(2371.27, 12.74, -8082.93),
	vec3(2373.83, 12.66, -8086.61),
	vec3(2374.28, 12.53, -8093.13)
}

local trigListTollKAZ = {

	-- 
	vec3(938.68, 19.42, -200.79),
	vec3(943.13, 19.42, -219.92),
	vec3(717.69, 21.14, -346.87),
	vec3(712.41, 21.05, -368.34),

	--
	vec3(-2635.21, -123.02, 502.43),
	vec3(-2644.12, -123.1, 503.97),

	--
	vec3(-3087.76, -125.71, -4027.39),
	vec3(-3084.63, -125.71, -4031.18),
	vec3(-3365.06, -134.3, -4300.21)

}

local ETCTollPlaySound = false
local byTollBooth = false
local cardError = 0
local paid = false
local etctollpaid = false
local paidTimer = os.clock()
local needspaid = false
local manualpaid = false
local manualpaidTimer = os.clock()
local fined = false
local finedtimer = os.clock()

function TollManagement()

    if fined then
        physics.setCarPenalty(ac.PenaltyType.TeleportToPits)
        paid = false
        needspaid = false
        fined = false
    end

    if paid then

        if trackType == 0 then
            --coord check
            for i, pos in ipairs(trigListTollKAZ) do
                if car.position:closerToThan(pos, 100) then
                    paidTimer = os.clock()
                end
            end
        elseif trackType == 1 then
            --coord check
            for i, pos in ipairs(trigListTollSRP) do
                if car.position:closerToThan(pos, 100) then
                    paidTimer = os.clock()
                end
            end
        end


        if paidTimer + 1 < os.clock() then
            paid = false
            needspaid = false
            etctollpaid = false
        end
        
    elseif paid == false and needspaid then
        
        if trackType == 0 then
            --coord check
            for i, pos in ipairs(trigListTollKAZ) do
                if car.position:closerToThan(pos, 100) then
                    finedtimer = os.clock()
                end
            end
        elseif trackType == 1 then
            --coord check
            for i, pos in ipairs(trigListTollSRP) do
                if car.position:closerToThan(pos, 100) then
                    finedtimer = os.clock()
                end
            end
        end


        if finedtimer + 2 < os.clock() then
            fined = true
        end

    end

    if ac.load('ETCCardExists') == 1 then

        if cardError == 1 then
            showMessageTollClock = os.clock()
            showMessageToll1 = true
            cardError = 0
        end

        if trackType == 0 then
            --coord check
            for i, pos in ipairs(trigListTollETCKAZ) do
                if car.position:closerToThan(pos, 2) then
                    ETCTollPlaySound = true
                    if ac.load('ETCCardInserted') == 0 and car.speedKmh < 30 then
                        cardError = 1
                    elseif car.speedKmh < 30 then
                        paid = true
                        etctollpaid = true
                        showMessageTollClock = os.clock()
                        showMessageToll0 = true
                    end
                    needspaid = true
                end
            end
        elseif trackType == 1 then
            --coord check
            for i, pos in ipairs(trigListTollETCSRP) do
                if car.position:closerToThan(pos, 2) then
                    ETCTollPlaySound = true
                    if ac.load('ETCCardInserted') == 0 and car.speedKmh < 30  then
                        cardError = 1
                    elseif car.speedKmh < 30 then
                        paid = true
                        etctollpaid = true
                        showMessageTollClock = os.clock()
                        showMessageToll0 = true
                    end
                    needspaid = true
                end
            end
        end
    
        if ETCTollPlaySound and ac.load('ETCCardExists') ~= nil then
            ac.store('ETCPlaySound', 1)
            ETCTollPlaySound = false
        else
            ac.store('ETCPlaySound', 0)
        end

    else

        if trackType == 0 then
            --coord check
            for i, pos in ipairs(trigListTollETCKAZ) do
                if car.position:closerToThan(pos, 2) then
                    needspaid = true
                end
            end
        elseif trackType == 1 then
            --coord check
            for i, pos in ipairs(trigListTollETCSRP) do
                if car.position:closerToThan(pos, 2) then
                    needspaid = true
                end
            end
        end

    end

    if manualpaid and manualpaidTimer + 5 < os.clock() then
        showMessageTollClock = os.clock()
        showMessageToll0 = true
        showMessageToll3 = false
        paid = true
        manualpaid = false
    end

    if paid == false and etctollpaid == false then

        if manualpaid then
            showMessageToll3 = true
            showMessageToll4 = false
            showMessageToll5 = false
        else

            if trackType == 0 then
                --coord check
                for i, pos in ipairs(trigListTollKAZ) do
                    if car.position:closerToThan(pos, 2) then
                        needspaid = true
                    end
                    if car.position:closerToThan(pos, 2) and car.speedKmh < 1 then
                        showMessageToll4 = true
                        showMessageToll5 = false
                        if ac.isKeyDown(32) then
                            manualpaid = true
                            manualpaidTimer = os.clock()
                        end
                    elseif car.position:closerToThan(pos, 4) and car.speedKmh > 1 and car.speedKmh < 30 then
                        showMessageToll4 = false
                        showMessageToll5 = true
                    end
                end
            elseif trackType == 1 then
                --coord check
                for i, pos in ipairs(trigListTollSRP) do
                    if car.position:closerToThan(pos, 2) then
                        needspaid = true
                    end
                    if car.position:closerToThan(pos, 2) and car.speedKmh < 1 then
                        showMessageToll4 = true
                        showMessageToll5 = false
                        if ac.isKeyDown(32) then
                            manualpaid = true
                            manualpaidTimer = os.clock()
                        end
                    elseif car.position:closerToThan(pos, 4) and car.speedKmh > 1 and car.speedKmh < 30 then
                        showMessageToll4 = false
                        showMessageToll5 = true
                    end
                end
            end

        end

    end

    if cardError == 1 and byTollBooth then
        showMessageTollClock = os.clock()
        showMessageToll2 = true
        cardError = 0
    end

end

local trigListKZ = {

    -- KANAZAWA CITY NORTH
	vec3(-3336.7, -138.62, -1188.61),
	vec3(-3341.02, -138.62, -1196.02),
	vec3(-3339.88, -138.61, -1186.36),
	vec3(-3344.52, -138.61, -1194.06),
	vec3(-3342.76, -138.61, -1185.14),
	vec3(-3347.04, -138.61, -1192.5),
	vec3(-3346.26, -138.61, -1183.14),
	vec3(-3350.59, -138.61, -1190.57),

    -- KANAZAWA CITY SOUTH
	vec3(-2951.24, -131.33, -20.54),
	vec3(-2954.96, -131.34, -18.69),
	vec3(-2957.77, -131.35, -17.55),
	vec3(-2961.71, -131.33, -16.01),
	vec3(-2964.42, -131.31, -14.45),
	vec3(-2968.09, -131.28, -13),
	vec3(-2971.2, -131.27, -12.18),
	vec3(-2974.76, -131.23, -10.25)

}

local trigListSRP = {

    -- SRP
vec3(-4515.52, 34.75, -6014.95),
vec3(-4521.3, 34.59, -6017.8)

}

local trigListEB = {

        -- EBISU
	vec3(-800.23, -101.87, 445.09),
	vec3(-803.32, -101.72, 444.62),
	vec3(-799.37, -101.86, 448.65),
	vec3(-803.05, -101.71, 448.44)

}

local trigListTS = {

    -- TSUKUBA CIRCUIT
    vec3(-20.27, 11.36, -148.73),
    vec3(-13.89, 11.36, -148.88),
    vec3(-20.61, 11.36, -144.8),
    vec3(-13.79, 11.36, -144.73)

}

local trigListIR = {

    -- IROHAZAKA
    vec3(-1106.09, 509.91, -333.46),
    vec3(-1102.63, 509.92, -333.41),
    vec3(-1098.22, 509.94, -334.02),
    vec3(-1094.71, 509.95, -334.44)

}

local price = 0
local fueladded = 0
local fuelchecktimer = os.clock()
local fuelcheck = 0
local fueltimewait = math.randomseed(sim.timeSeconds)
local fuelTimeEmergencyWait = os.clock()
local fuelTimeInitialWait = false
local fuelEmergency = false

function Fuel()

    local car0 = ac.getCarState(0)
    local car1 = ac.getCarState(1)
    local car2 = ac.getCarState(2)

    if not fuelTimeInitialWait then
        fueltimewait = math.random(1, 30) / secretReward
        fuelTimeInitialWait = true
    end

    if fuelchecktimer + 0.7 < os.clock() then
        fuelchecktimer = os.clock()
        fuelcheck = car.fuel
    end

    if fuelcheck - car.fuel > 0.666 or car.fuel - fuelcheck > 0.666 then
        physics.setCarFuel(0, fuel)
    else
        fuel = car.fuel
    end

    if car.speedKmh < 1 and car.fuel < 0.05 and not fuelEmergency and not showMessageERefuel3 and not showMessageERefuel2 then
        showMessageERefuel0 = true
        if ac.isKeyDown(32) then
            fuelTimeEmergencyWait = os.clock()
            fuelEmergency = true
            showMessageERefuel0 = false
        end
    elseif car.speedKmh > 0 or car.fuel > 0.05 then
        showMessageERefuel0 = false
    end

    if fuelEmergency then
        showMessageERefuel1 = true

        if fuelTimeEmergencyWait + (fueltimewait * 60) < os.clock() then
            showMessageERefuel2 = true
            showMessageERefuelClock = os.clock()
            fuel = 5
            fuelcheck = 5
            physics.setCarFuel(0, 5)
            fuelEmergency = false
        end

        if ac.isKeyDown(17) and ac.isKeyDown(16) and ac.isKeyDown(9) then
            showMessageERefuelClock = os.clock()
            showMessageERefuel3 = true
            fuelEmergency = false
        end
        
    else
        showMessageERefuel1 = false
    end

    if trackType == 0 and car.speedKmh < 1 then
        for i, pos in ipairs(trigListKZ) do
            if car.position:closerToThan(pos, 2) then
                if ac.isKeyDown(32) and car.fuel < car.maxFuel then
                    showMessageRefuel1 = true
                    physics.setCarFuel(0, car.fuel + 0.025)
                    fueladded = fueladded + 0.025
                else
                    showMessageRefuel0 = true
                end
            end
        end
    elseif trackType == 1 and car.speedKmh < 1 then
        for i, pos in ipairs(trigListSRP) do
            if car.position:closerToThan(pos, 2) then
                if ac.isKeyDown(32) and car.fuel < car.maxFuel then
                    showMessageRefuel1 = true
                    physics.setCarFuel(0, car.fuel + 0.025)
                    fueladded = fueladded + 0.025
                else
                    showMessageRefuel0 = true
                end
            end
        end
    elseif trackType == 2 and car.speedKmh < 1 then
        for i, pos in ipairs(trigListEB) do
            if car.position:closerToThan(pos, 2) then
                if ac.isKeyDown(32) and car.fuel < car.maxFuel then
                    showMessageRefuel1 = true
                    physics.setCarFuel(0, car.fuel + 0.025)
                    fueladded = fueladded + 0.025
                else
                    showMessageRefuel0 = true
                end
            end
        end
    elseif trackType == 3 and car.speedKmh < 1 then
        for i, pos in ipairs(trigListTS) do
            if car.position:closerToThan(pos, 2) then
                if ac.isKeyDown(32) and car.fuel < car.maxFuel then
                    showMessageRefuel1 = true
                    physics.setCarFuel(0, car.fuel + 0.025)
                    fueladded = fueladded + 0.025
                else
                    showMessageRefuel0 = true
                end
            end
        end
    elseif trackType == 4 and car.speedKmh < 1 then
        for i, pos in ipairs(trigListIR) do
            if car.position:closerToThan(pos, 2) then
                if ac.isKeyDown(32) and car.fuel < car.maxFuel then
                    showMessageRefuel1 = true
                    physics.setCarFuel(0, car.fuel + 0.025)
                    fueladded = fueladded + 0.025
                else
                    showMessageRefuel0 = true
                end
            end
        end
    else
        fueladded = 0
    end


end

function LoadCheckingCoords()

    if coordLoadingTimer + 1 < os.clock() then
        coordLoadCheck = true
    end

    physics.setCarFuel(0, storedValues.fuel)
    physics.setCarEngineLife(0, storedValues.engineDamage)

    if mapAdvance == false then

        if storedValues.map0 == ac.getTrackID() and storedValues.calledTow == 0 and storedValues.carOrientationMap0X ~= 0 then
            carPosition.x = storedValues.carPositionMap0X
            carPosition.y = storedValues.carPositionMap0Y
            carPosition.z = storedValues.carPositionMap0Z
            carOrientation.x = storedValues.carOrientationMap0X
            carOrientation.y = storedValues.carOrientationMap0Y
            carOrientation.z = storedValues.carOrientationMap0Z
            physics.setCarPosition(0, carPosition, carOrientation)
            physics.setCarEngineLife(0, storedValues.engineDamage)
            storedValues.map0 = ac.getTrackID()
            mapType = 0
        elseif storedValues.map1 == ac.getTrackID() and storedValues.calledTow == 0 and storedValues.carOrientationMap1X ~= 0 then
            carPosition.x = storedValues.carPositionMap1X
            carPosition.y = storedValues.carPositionMap1Y
            carPosition.z = storedValues.carPositionMap1Z
            carOrientation.x = storedValues.carOrientationMap1X
            carOrientation.y = storedValues.carOrientationMap1Y
            carOrientation.z = storedValues.carOrientationMap1Z
            physics.setCarPosition(0, carPosition, carOrientation)
            physics.setCarEngineLife(0, storedValues.engineDamage)
            storedValues.map1 = ac.getTrackID()
            mapType = 1
        elseif storedValues.mapType == 0 then
            storedValues.map1 = ac.getTrackID()
            mapType = 1
        elseif storedValues.mapType == 1 then
            storedValues.map0 = ac.getTrackID()
            mapType = 0
        end

        mapAdvance = true

    end

end

function StoredValuesLoadingCoords()

    if storedValues.map1 == '' then
        storedValues.map1 = ac.getTrackID()
    elseif storedValues.map0 == '' then
        storedValues.map0 = ac.getTrackID()
    end

    storedValues.mapType = mapType

    if mapType == 0 then
        storedValues.carPositionMap0X = carPosition.x
        storedValues.carPositionMap0Y = carPosition.y
        storedValues.carPositionMap0Z = carPosition.z
        storedValues.carOrientationMap0X = carOrientation.x
        storedValues.carOrientationMap0Y = carOrientation.y
        storedValues.carOrientationMap0Z = carOrientation.z
    else
        storedValues.carPositionMap1X = carPosition.x
        storedValues.carPositionMap1Y = carPosition.y
        storedValues.carPositionMap1Z = carPosition.z
        storedValues.carOrientationMap1X = carOrientation.x
        storedValues.carOrientationMap1Y = carOrientation.y
        storedValues.carOrientationMap1Z = carOrientation.z
    end
end

local callMechanicPrompt = false
local randomTimeAmountClock = os.clock()
local timewait = math.randomseed(sim.timeSeconds)
local calledMechanic = false
local mechanicClockWaitTime = os.clock()
local atMechanicTimer = os.clock()
local repair = false
local repaired = false
local randomseedmake = false
local disablePitsTimer = os.clock()

function SaveCarPosition()

    if not randomseedmake then
        timewait = math.random(1, 30) / secretReward
        randomseedmake = true
    end

    if car.speedKmh < 1 and repair == false and car.position:closerToThan(vec3(-2946.11, -131.83, -40.4), 15) or car.speedKmh < 1 and repair == false and car.position:closerToThan(vec3(-3360.04, -138.6, -1194.99), 15) and ac.getServerPortHTTP() == 8282 then
        showMessageRepair0 = true
        if ac.isKeyDown(32) then
            repair = true
        end
    end

    if car.speedKmh < 1 and repair == false and car.position:closerToThan(vec3(-4755.13, 34.23, -5822.78), 5) and trackType == 1 then
        showMessageRepair0S = true
        if ac.isKeyDown(32) then
            repair = true
        end
    end

    if repair and repaired == false then
        showMessageRepair1 = true
        physics.resetCarState(0, 0.5)
        engineDamage = 1000
        physics.setCarFuel(0, fuel)
        repaired = true
    end

    if trackType == 0 and car.position:closerToThan(vec3(-2946.11, -131.83, -40.4), 15) == false and car.position:closerToThan(vec3(-3360.04, -138.6, -1194.99), 15) == false and repair then
        repair = false
        repaired = false
    end

    if trackType == 1 and car.position:closerToThan(vec3(-4755.13, 34.23, -5822.78), 5) == false and repair then
        repair = false
        repaired = false
    end

    carPosition = vec3(car.position.x, car.position.y, car.position.z)
    carOrientation = ac.getCameraDirection()

    if car.speedKmh < 1 and ac.isKeyDown(16) and ac.isKeyDown(36) and teleportToPits == false then
        callMechanicPrompt = true
    end

    if callMechanicPrompt then
        showMessageERepair0 = true
        if ac.isKeyDown(32) then
            mechanicClockWaitTime = os.clock()
            calledMechanic = true
            callMechanicPrompt = false
        elseif ac.isKeyDown(17) then
            callMechanicPrompt = false
        end
    else
        showMessageERepair0 = false
    end

    if calledMechanic then
        if mechanicClockWaitTime + (timewait * 60) < os.clock() then
            storedValues.calledTow = 1
            if ac.getServerPortHTTP() ~= 8282 then
                ac.reconnectTo({serverIP = '74.132.225.61', serverPort = 9801, serverHttpPort = 8282})
            end
        end

        showMessageERepair1 = true

        if ac.isKeyDown(17) and ac.isKeyDown(16) and ac.isKeyDown(9) then
            showMessageERepair2 = true
            showMessageERepairClock = os.clock()
            callMechanicPrompt = false
            calledMechanic = false
        end
    else
        showMessageERepair1 = false
    end

    if storedValues.calledTow == 1 and calledMechanic then
        calledMechanic = false
        callMechanicPrompt = false
        atMechanicTimer = os.clock()
    end

    if calledMechanic == false and atMechanicTimer + 1 < os.clock() and storedValues.calledTow == 1 then
        physics.setCarPosition(0, vec3(-2946.11, -131.83, -40.4), ac.getCameraDirection())
        storedValues.calledTow = 0
    end

    if teleportToPits and justteleported == false then
        ac.tryToTeleportToPits()
        ac.tryToOpenRaceMenu('setup')
        justteleported = true
        teleporttimer = os.clock()
        teleportToPits = false
    end

    if justteleported and teleporttimer + 0.01 < os.clock() then
        physics.setCarPosition(0, coords, orientation)
        justteleported = false
    end

    if collisionTimer + 10 < os.clock() then
        physics.disableCarCollisions(0, false)
    else
        physics.disableCarCollisions(0, true)
    end

    if randomTimeAmountClock + 20000 < os.clock() then
        timewait = math.random(1, 30) / secretReward
        fueltimewait = math.random(1, 30) / secretReward
        randomTimeAmountClock = os.clock()
    end

end

local displayRewardMessage = false

function FindLocationsExtra()

    --- SRP ---

    if not location0 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(-7153.43, 11.28, 11241.42), 15) and trackType == 1 then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location0 = true
        end
    end

    if not location1 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(2174.12, -7.67, -8796.67), 15) and trackType == 1 then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location1 = true
        end
    end

    if not location2 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(4204.42, 16.6, -8492.25), 15) and trackType == 1 then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location2 = true
        end
    end

    if not location3 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(-2195.42, 27.08, -8699.09), 15) and trackType == 1 then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location3 = true
        end
    end

    if not location4 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(964.63, 6.08, -80.02), 15) and trackType == 1 then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location4 = true
        end
    end

    --- KZ ---

    if not location5 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(2942.45, -50.18, -471.07), 15) and trackType == 0 then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location5 = true
        end
    end

    if not location6 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(1167.81, 101.78, 1498.92), 15) and trackType == 0 then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location6 = true
        end
    end
    
    if not location7 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(-1497.06, -44.17, 825.44), 15) and trackType == 0 then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location7 = true
        end
    end
    
    if not location8 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(-3170.11, -136.58, -811.7), 15) and trackType == 0 then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location8 = true
        end
    end

    if not location9 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(-1456.84, -74.9, -839.96), 15) and trackType == 0 then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location9 = true
        end
    end

    --- OTHERS ---

    if not location10 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(211.34, 465.91, -672.94), 15) and ac.getTrackID() == 'pk_akina' then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location10 = true
        end
    end

    if not location11 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(-1010.9, -8.55, -293.01), 15) and ac.getTrackID() == 'ebisu_complex' then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location11 = true
        end
    end

    if not location12 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(-735.18, -11.45, 98.18), 15) and ac.getTrackID() == 'rt_fuji_speedway' then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location12 = true
        end
    end

    if not location13 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(-384.49, 249.78, -456.96), 15) and ac.getTrackID() == 'myogi_fixed' then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location13 = true
        end
    end

    if not location14 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(544, 78.47, 1802.47), 15) and ac.getTrackID() == 'rtp_nagao_beta_iii' then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location14 = true
        end
    end

    if not location15 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(-798.36, 12.09, -999.92), 15) and ac.getTrackID() == 'sj_shomaru' then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location15 = true
        end
    end

    if not location16 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(-965.77, -0.259, 59.9), 15) and ac.getTrackID() == 'rt_suzuka' then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location16 = true
        end
    end

    if not location17 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(-789.73, -218.01, -363.79), 15) and ac.getTrackID() == 'rtp_tsuchisaka_beta_ii' then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location17 = true
        end
    end

    if not location18 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(-294.41, 8.96, -250.92), 15) and ac.getTrackID() == 'ddm_gts_tsukuba' then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location18 = true
        end
    end

    if not location19 and car.speedKmh < 20 and not locationSecret and car.position:closerToThan(vec3(2131.58, 547.95, -398.48), 15) and ac.getTrackID() == 'pk_usui_touge' then
        showMessageSecrets0 = true
        showMessageSecrets = os.clock()
        if ac.isKeyDown(32) then
            locationSecretNumber = locationSecretNumber + 1
            locationSecretTimer = os.clock()
            locationSecret = true
            location19 = true
        end
    end

    if locationSecret then
        showMessageSecrets1 = true
        showMessageSecrets0 = false
    end
    if locationSecretTimer + 5 > os.clock() and locationSecret then
        locationSecret = false
    end

    if locationSecretNumber > 19 then
        secretReward = 2
        locationSecretNumber = -1
        displayRewardMessage = true
    end

    if displayRewardMessage then
        showMessageSecrets1 = false
        showMessageSecrets2 = true
        displayRewardMessage = false
    end

    ac.debug('secret locations', locationSecretNumber)

end

local uberRandomizer = math.randomseed(sim.timeSeconds + ac.getCameraDirection().z)

local restrauntPickup = {
{'McDonalds', vec3(-2892.26, -127.84, 165.92)},
{'LowStyle', vec3(-2689.69, -120.96, 275.91)},
{'Family Mart', vec3(-2925.38, -129.65, 119.15)},
{'Karubitaisho Tagamiten', vec3(-2950.1, -130.7, 26.45)},
{'Kaitensushi Kanazawa Tagami', vec3(-3046.18, -135.11, -579.88)},
{'Dominos', vec3(-3198.98, -137.67, -1043.15)},
{'McDonalds', vec3(-3178.45, -137.66, -1064.08)},
{'Xinhexuan Dumplings', vec3(-3178.45, -137.66, -1064.08)},
{'EARTH BURGER', vec3(-3097.27, -134.61, -1189.6)},
{'Chashu-tei Morinosato Restraunt', vec3(-3186.12, -136.56, -1190.26)},
{'Lonely Mart', vec3(-3433.35, -138.68, -1439.31)},
{'Seventh Dumpling Shop', vec3(-3184.16, -137.01, -914.46)},
{'Sukiya Kanazawa Tagami', vec3(-3120.13, -135.56, -688.09)},
{'Komeda\'s Coffee', vec3(-3128.28, -135.78, -725.9)},
{'Furan Doru Valle Shop', vec3(-3120.96, -134.01, -333.87)},
{'Dining Ryo Kichi', vec3(-2869.13, -126.95, 178.81)},
{'Lonely Mart', vec3(608.19, 47.6, 195.77)},
{'Lonely Mart', vec3(-1925.18, -102.47, -1009.18)}
}

local restrauntDropoff = {
vec3(-3727.85, -138.54, -1940.53),
vec3(-3828.46, -138.26, -1941.29),
vec3(-3909.12, -137.74, -2026.9),
vec3(-3745.67, -138.55, -1836.55),
vec3(-3702.7, -138.57, -1742.91),
vec3(-3596.41, -138.6, -1594.74),
vec3(-3537.52, -138.61, -1514.02),
vec3(-3492.11, -138.61, -1433.74),
vec3(-3443.67, -138.62, -1361.45),
vec3(-3386.84, -138.61, -1257.96),
vec3(-3162.31, -136.72, -840.13),
vec3(-3166.08, -135.8, -716.53),
vec3(-3170.42, -135.4, -640.2),
vec3(-2886.65, -127.64, 219.73),
vec3(-2997.08, -135.77, -279.66),
vec3(-3003.67, -135.59, -339.41),
vec3(-2992.75, -133.65, -416.74),
vec3(-2997.77, -133.77, -475.01),
vec3(-3001.03, -134.17, -547.11),
vec3(-3005.58, -134.4, -618.45),
vec3(-3067.02, -135.79, -656.58),
vec3(-3086.22, -136.11, -759.45),
vec3(-3067.14, -135.85, -821.98),
vec3(-3127.24, -136.8, -884.88),
vec3(-3221.97, -137.35, -1178.77),
vec3(-3345.07, -138.67, -1278.96),
vec3(-3395.75, -138.67, -1371.56),
vec3(-3453.64, -138.69, -1501.83),
vec3(-3516.34, -138.68, -1582.57),
vec3(-3583.32, -138.66, -1667.88),
vec3(-3080.13, -133.86, -1242.75),
vec3(3010.34, -62.93, -856.3),
vec3(2962.3, -57.06, -685.45),
vec3(2949.05, -52.83, -551.95),
vec3(2870.32, 232.62, 1569.08),
vec3(2014.81, 236.12, 2359.22),
vec3(1186.12, 99.57, 1480.56),
vec3(1218.47, 99.48, 1445.17),
vec3(-1553.33, -42.44, 756.52),
vec3(-1496.72, -44.04, 820.3),
vec3(-1486.68, -44.88, 846.66),
vec3(-1481.5, -45.66, 875.74),
vec3(-1486.25, -50.29, 994.98),
vec3(-1483.33, -48.78, 942.23),
vec3(-2411.83, -112.29, 392.12)
}

local uberAssignment = {
'',
vec3(),
vec3()

}

local displayUberJobMessage = false
local displayerUberDropoff = false
local displayUberFinished = false
local displayerUberFinishedtimer = os.clock()
local displayUberCanceled = false
local acceptedUberJob = false
local generateUberJob = false
local jobCount = 0

-- parts deliver
-- find parts around map
-- 

function Jobs()

    if trackType == 0 then

        if not acceptedUberJob then
            ac.Particles.Flame({color = rgbm(0, 0, 1, 0.5), size = 1, temperatureMultiplier = 2, flameIntensity = 2}):emit(vec3(-3022.4, -134.84, -224.02), vec3(0,2,0), 0.4)
            --ac.Particles.Flame({color = rgbm(0, 0, 1, 0.5), size = 1, temperatureMultiplier = 2, flameIntensity = 2}):emit(vec3(-3015.36, -135, -227.21), vec3(0,2,0), 0.4)
            --ac.Particles.Flame({color = rgbm(0, 0, 1, 0.5), size = 1, temperatureMultiplier = 2, flameIntensity = 2}):emit(vec3(-3008.7, -135.15, -229.89), vec3(0,2,0), 0.4)
        end

        if car.position:closerToThan(vec3(-3022.4, -134.84, -224.02), 5) and not acceptedUberJob then
            displayUberJobMessage = true
            if ac.isKeyDown(32) then
                acceptedUberJob = true
                generateUberJob = true
            end
        else
            displayUberJobMessage = false
        end

        if acceptedUberJob then

            if ac.isKeyDown(17) and ac.isKeyDown(16) and ac.isKeyDown(9) then
                jobCount = 0
                displayerUberFinishedtimer = os.clock()
                displayUberCanceled = true
                acceptedUberJob = false
            end

            if not displayerUberDropoff then

                ac.Particles.Flame({color = rgbm(0, 0, 1, 0.5), size = 1, temperatureMultiplier = 2, flameIntensity = 2}):emit(vec3(uberAssignment[2].x,uberAssignment[2].y,uberAssignment[2].z), vec3(0,2,0), 0.4)  
                if car.position:closerToThan(vec3(uberAssignment[2].x,uberAssignment[2].y,uberAssignment[2].z), 5) then
                    
                    if ac.isKeyDown(32) then
                        displayerUberDropoff = true
                    end

                end


            else
                ac.Particles.Flame({color = rgbm(0, 0, 1, 0.5), size = 1, temperatureMultiplier = 2, flameIntensity = 2}):emit(vec3(uberAssignment[3].x,uberAssignment[3].y,uberAssignment[3].z), vec3(0,2,0), 0.4)  
                if car.position:closerToThan(vec3(uberAssignment[3].x,uberAssignment[3].y,uberAssignment[3].z), 5) then
                    
                    if ac.isKeyDown(32) then
                        generateUberJob = true
                        displayerUberDropoff = false
                    end

                end

            end

            if jobCount > 10 then
                displayerUberFinishedtimer = os.clock()
                displayUberFinished = true
                acceptedUberJob = false
                jobCount = 0
            end


        end

        if generateUberJob then
            uberRandomizer = math.random(1,#restrauntPickup)
            uberAssignment[1] = restrauntPickup[uberRandomizer] [1]
            uberAssignment[2] = restrauntPickup[uberRandomizer] [2]
            uberRandomizer = math.random(1,#restrauntDropoff)
            uberAssignment[3] = restrauntDropoff[uberRandomizer]
            jobCount = jobCount + 1
            generateUberJob = false
        end

        --ac.debug('uber', uberAssignment)
        --ac.debug('uber jobs', jobCount)

    end

end



local uiColor = rgbm(100, 100, 100, 100)

--function script.draw3D()

--end

local stickColor = rgbm(0.3,0.3,0.3,1)
local stickColorGroove = rgbm(0.25,0.25,0.25,1)
local sticktoggle = false
local sticktoggleadd = 0
local sticktoggled = false
local oilcaptoggled = false
local oilSnapped = false
local oilPouring = false
local oilDraining = false

function script.drawUI()

    uiState = ac.getUI()


    if sticktoggleadd > 1 then
        sticktoggleadd = 0
    end

    if ac.isKeyDown(121) and car.speedKmh < 1 and not sticktoggle then
        sticktoggleadd = sticktoggleadd + 1
        sticktoggle = true
    end

    if sticktoggle and not ac.isKeyDown(121) then
        sticktoggle = false
    end

    if sticktoggleadd == 1 then
        if car.gear ~= 0 then
            physics.forceUserThrottleFor(1, 0)
        end

        ui.toolWindow('EngineBay', vec2(uiState.windowSize.x / 4, uiState.windowSize.y/6), vec2(uiState.windowSize.x / 2,uiState.windowSize.y/1.4), function ()

            ui.pushFont(ui.Font.Huge)

            ui.childWindow('stupid brainrot lua', vec2(uiState.windowSize.x / 2, uiState.windowSize.y/1.4), false, ui.WindowFlags.None, function ()

                if not sticktoggled then

                    --- STARTSTOP ---
                    
                    ui.drawCircle(vec2(60,690), 20, rgbm(0.6,0,0,1), 40, 45)
                    ui.drawCircle(vec2(60,690), 40, rgbm(0.5,0,0,1), 40, 15)

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(35)
                    ui.setCursorY(665)
                    ui.textColored('START', rgbm(0,0,0,1))
                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(38)
                    ui.setCursorY(690)
                    ui.textColored('STOP', rgbm(0,0,0,1))

                    ui.setCursorX(10)
                    ui.setCursorY(640)

                    if ui.invisibleButton('START STOP', vec2(100,100)) then
                        if engineIsOn then
                            engineIsOn = false
                        else
                            engineIsOn = true
                        end
                        
                    end
                    

                    --- CHECK OIL ---   

                    ui.drawCircle(vec2(100,80), 30, rgbm(0.3,0,0,1), 40, 45)
                    ui.drawCircle(vec2(100,80), 20, rgbm(0.35,0,0,1), 40, 45)
                    ui.drawLine(vec2(50,80), vec2(150,80), rgbm(0.5,0,0,1), 20)

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(60.7)
                    ui.setCursorY(67)
                    ui.textColored('OIL LEVEL', rgbm(0,0,0,1))

                    ui.setCursorX(60.7)
                    ui.setCursorY(67)

                    if ui.invisibleButton('CHECK OIL', vec2(150,80)) and not oilSnapped then
                        sticktoggled = true
                    end

                    if oilcaptoggled then

                        ui.drawCircle(vec2(250,80), 10, rgbm(0.02,0.02,0.02,1), 40, 20)
                        ui.drawCircle(vec2(250,80), 22, rgbm(0.07,0.07,0.07,1), 40, 8)
                        ui.drawCircle(vec2(250,80), 27, rgbm(0.1,0.1,0.1,1), 40, 8)
                        ui.drawCircle(vec2(250,80), 32, rgbm(0.13,0.13,0.13,1), 40, 8)
                        ui.drawCircle(vec2(250,80), 37, rgbm(0.17,0.17,0.17,1), 40, 8)
                        ui.drawCircle(vec2(250,80), 42, rgbm(0.2,0.2,0.2,1), 40, 8)

                        if oilAmount > 150 then
                            ui.drawCircle(vec2(250,80), 10, rgbm(0.32,0.32,0,(math.abs(150 - math.max(150, oilAmount)))/150 * 5), 40, math.max(20, oilAmount - 130))
                        end

                        if oilSnapped then
                            ui.setCursorX(ui.mouseLocalPos().x - 40)
                            ui.setCursorY(ui.mouseLocalPos().y - 60)
                        else
                            ui.setCursorX(800)
                            ui.setCursorY(600)
                        end

                        ui.image('https://static.vecteezy.com/system/resources/previews/009/381/185/non_2x/motor-oil-bottle-clipart-design-illustration-free-png.png',vec2(100,140))

                        if oilSnapped then

                            ui.setCursorX(235)
                            ui.setCursorY(95)
                            ui.invisibleButton('OIL FILL', vec2(80,70))

                            if ui.itemHovered() and oilAmount < 170 then
                                oilPouring = true
                                ui.setCursorX(ui.mouseLocalPos().x - 150)
                                ui.setCursorY(ui.mouseLocalPos().y - 50)
                                ui.drawCircle(vec2(ui.mouseLocalPos().x - 23,ui.mouseLocalPos().y - 75), 5, rgbm(0.32,0.32,0,1), 40, 15)
                                ui.drawCircle(vec2(ui.mouseLocalPos().x - 23,ui.mouseLocalPos().y - 75), 4, rgbm(0.37,0.37,0,1), 40, 15)
                                ui.drawCircle(vec2(ui.mouseLocalPos().x - 23,ui.mouseLocalPos().y - 75), 3, rgbm(0.45,0.45,0,1), 40, 15)
                                oilAmount = oilAmount + 0.0025
                                if oilQuality < 100 then
                                    oilQuality = oilQuality + 0.0025
                                end
                            else
                                oilPouring = false
                            end

                            ui.setCursorX(ui.mouseLocalPos().x - 40)
                            ui.setCursorY(ui.mouseLocalPos().y - 60)
                            if ui.invisibleButton('OIL BOTTLE', vec2(110,140)) and not oilPouring then
                                oilSnapped = false
                            end

                        else
                            ui.setCursorX(795)
                            ui.setCursorY(600)
                            if ui.invisibleButton('OIL BOTTLE', vec2(110,140)) then
                                oilSnapped = true
                            end
                        end


                    else

                        ui.drawCircle(vec2(250,80), 30, rgbm(0.02,0.02,0.02,1), 40, 55)
                        ui.drawCircle(vec2(250,80), 49, rgbm(0.6,0.6,0.02,1), 40, 3)

                        ui.setCursorX(218)
                        ui.setCursorY(46)
                        ui.textColored('ENGINE', rgbm(0.6,0.6,0.02,1))

                        ui.setCursorX(235)
                        ui.setCursorY(88)
                        ui.textColored('OIL', rgbm(0.6,0.6,0.02,1))

                        ui.drawLine(vec2(190,80), vec2(310,80), rgbm(0.03,0.03,0.03,1), 20)

                    end
                    
                    ui.setCursorX(190)
                    ui.setCursorY(20)

                    if ui.invisibleButton('OIL', vec2(120,120)) then
                        if oilcaptoggled then
                            oilcaptoggled = false
                        else
                            oilcaptoggled = true
                        end
                    end

                    ui.setCursorX(350)
                    ui.setCursorY(30)

                    if ui.invisibleButton('OIL DRAIN', vec2(90,110)) then
                        if oilDraining or oilAmount < 0.1 then
                            oilDraining = false
                        else
                            oilDraining = true
                            
                        end
                    end

                    if oilDraining then
                        ui.setCursorX(351)
                        ui.setCursorY(110)
                        ui.textColored('DRAINING...', rgbm(0.0,0.0,0.0,1)) 
                        oilAmount = oilAmount - 0.01
                    else
                        ui.setCursorX(368)
                        ui.setCursorY(110)
                        ui.textColored('DRAIN', rgbm(0.0,0.0,0.0,1))    
                    end

                    if oilAmount < 0.1 and oilDraining then
                        oilDraining = false
                        oilAmount = 0
                        oilQuality = 100
                    end

                    ui.setCursorX(360)
                    ui.setCursorY(25)
                    ui.image('https://cdn4.iconfinder.com/data/icons/automotive-maintenance/100/automotive-oil-drain-pan2-512.png',vec2(70,90))

                    

                
                end

                if sticktoggled then
                    
                    ui.drawLine(vec2(100,100), vec2(600,100), stickColor, 40)
                    ui.drawTriangle(vec2(600,100.5), vec2(600,100.5), vec2(680,100.5), stickColor, 40)
                    ui.drawLine(vec2(630,100), vec2(730,100), stickColor, 10)

                    -- markers

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(275)
                    ui.setCursorY(87)
                    ui.textColored('MAX',stickColorGroove)
                    ui.drawLine(vec2(560,80), vec2(560,120), stickColorGroove, 2)
                    ui.drawLine(vec2(320,80), vec2(320,120), stickColorGroove, 2)

                    -- detail lines

                    ui.drawLine(vec2(320,100), vec2(340,120), stickColorGroove, 2)
                    ui.drawLine(vec2(320,100), vec2(340,80), stickColorGroove, 2)

                    ui.drawLine(vec2(320,80), vec2(360,120), stickColorGroove, 2)
                    ui.drawLine(vec2(340,80), vec2(380,120), stickColorGroove, 2)
                    ui.drawLine(vec2(360,80), vec2(400,120), stickColorGroove, 2)
                    ui.drawLine(vec2(380,80), vec2(420,120), stickColorGroove, 2)
                    ui.drawLine(vec2(400,80), vec2(440,120), stickColorGroove, 2)
                    ui.drawLine(vec2(420,80), vec2(460,120), stickColorGroove, 2)
                    ui.drawLine(vec2(440,80), vec2(480,120), stickColorGroove, 2)
                    ui.drawLine(vec2(460,80), vec2(500,120), stickColorGroove, 2)
                    ui.drawLine(vec2(480,80), vec2(520,120), stickColorGroove, 2)
                    ui.drawLine(vec2(500,80), vec2(540,120), stickColorGroove, 2)
                    ui.drawLine(vec2(520,80), vec2(560,120), stickColorGroove, 2)

                    ui.drawLine(vec2(320,120), vec2(360,80), stickColorGroove, 2)
                    ui.drawLine(vec2(340,120), vec2(380,80), stickColorGroove, 2)
                    ui.drawLine(vec2(360,120), vec2(400,80), stickColorGroove, 2)
                    ui.drawLine(vec2(380,120), vec2(420,80), stickColorGroove, 2)
                    ui.drawLine(vec2(400,120), vec2(440,80), stickColorGroove, 2)
                    ui.drawLine(vec2(420,120), vec2(460,80), stickColorGroove, 2)
                    ui.drawLine(vec2(440,120), vec2(480,80), stickColorGroove, 2)
                    ui.drawLine(vec2(460,120), vec2(500,80), stickColorGroove, 2)
                    ui.drawLine(vec2(480,120), vec2(520,80), stickColorGroove, 2)
                    ui.drawLine(vec2(500,120), vec2(540,80), stickColorGroove, 2)
                    ui.drawLine(vec2(520,120), vec2(560,80), stickColorGroove, 2)

                    ui.drawLine(vec2(540,120), vec2(560,100), stickColorGroove, 2)
                    ui.drawLine(vec2(540,80), vec2(560,100), stickColorGroove, 2)



                    ui.drawLine(vec2((600 - (oilAmount * 2.8)),100), vec2(600,100), oilColor, 35)
                    ui.drawTriangle(vec2(600,100.5), vec2(600,100.5), vec2(680,100.5), oilColor, 35)
                    ui.drawLine(vec2(660,100), vec2(730,100), oilColor, 8)

                    ui.setCursorX(90)
                    ui.setCursorY(70)

                    if ui.invisibleButton('CHECK OIL', vec2(650,60)) then
                        sticktoggled = false
                    end

                end

            end)

        end)

    end



    if displayUberJobMessage or acceptedUberJob or displayUberFinished then
        ui.transparentWindow('UberMessage', vec2(0, 100), vec2(uiState.windowSize.x,uiState.windowSize.y), function ()
            ui.pushFont(ui.Font.Huge)
            if displayUberFinished and displayerUberFinishedtimer + 5 > os.clock() then
                ui.textAligned('Finished!', 0.5, vec2(uiState.windowSize.x,0))
            elseif displayerUberFinishedtimer + 6 < os.clock() then
                displayUberFinished = false
            end

            if displayUberCanceled and displayerUberFinishedtimer + 5 > os.clock() then
                ui.textAligned('Job Canceled', 0.5, vec2(uiState.windowSize.x,0))
            elseif displayerUberFinishedtimer + 6 < os.clock() then
                displayUberCanceled = false
            end
        
            if acceptedUberJob then
                ui.pushFont(ui.Font.Title)
                if not displayUberCanceled then
                    ui.text('Press [CTRL] + [SHIFT] + [TAB] to cancel.')
                end

                if not displayerUberDropoff then
                    ui.pushFont(ui.Font.Title)
                    ui.text('Pick Up From the Following Place')
                    ui.text(uberAssignment[1])
                    ui.text('Distance Remaining')
                    ui.text(math.round((uberAssignment[2].x + uberAssignment[2].z) - (car.position.x + car.position.z), 1))
                    ui.text('Press [SPACE] at Destination')
                else
                    ui.pushFont(ui.Font.Title)
                    ui.text('Drop Off Distance Remaining')
                    ui.text(math.round((uberAssignment[2].x + uberAssignment[2].z) - (car.position.x + car.position.z), 1))
                    ui.text('Press [SPACE] at Destination')
                end

            elseif not displayUberFinished or displayUberCanceled then
                ui.textAligned('Uber Eats Job', 0.5, vec2(uiState.windowSize.x,0))
        
                ui.pushFont(ui.Font.Title)
                ui.textAligned('Go to 10 Different Locations and deliver Food', 0.498, vec2(uiState.windowSize.x,0))
                ui.textAligned('Press [SPACE] to accept', 0.5, vec2(uiState.windowSize.x,0))
            end
        end)
    end
    


    if showMessageRefuel0 or showMessageRefuel1 then
        ui.transparentWindow('RefuelMessage', vec2(uiState.windowSize.x / 2 - 350, 100), vec2(700,uiState.windowSize.y - 100), function ()
            ui.pushFont(ui.Font.Huge)
            if showMessageRefuel1 then
                ui.textAligned('Refueling...', 0.14, vec2(uiState.windowSize.x,0))
            elseif showMessageRefuel0 then
                ui.textAligned('Press [SPACEBAR] to refuel car', 0.02, vec2(uiState.windowSize.x,0))
            end
            if showMessageRefuel1 and ac.isKeyDown(32) then
                showMessageRefuel1 = false
            end
            if car.speedKmh > 1 then
                showMessageRefuel0 = false
            end
        end)
    end

    if showMessageRepair0 or showMessageRepair0S or showMessageRepair1 then
        ui.transparentWindow('RepairMessage', vec2(uiState.windowSize.x / 2 - 350, 100), vec2(700,uiState.windowSize.y - 100), function ()
            ui.pushFont(ui.Font.Huge)
            if showMessageRepair1 then
                ui.textAligned('Car Repaired!', 0.13, vec2(uiState.windowSize.x,0))
            elseif showMessageRepair0 or showMessageRepair0S then
                if showMessageRepair0 then
                    ui.pushFont(ui.Font.Huge)
                    ui.textAligned('Press [SPACEBAR] to repair car', 0.02, vec2(uiState.windowSize.x,0))
                elseif showMessageRepair0S then
                    ui.pushFont(ui.Font.Huge)
                    ui.textAligned('Press [SPACEBAR] to repair car', 0.02, vec2(uiState.windowSize.x,0))
                    ui.pushFont(ui.Font.Title)
                    ui.textAligned('Secret Car Repair Shop', 0.14, vec2(uiState.windowSize.x,0))
                end
            end
            ui.pushFont(ui.Font.Huge)
            if car.speedKmh > 1 then
                showMessageRepair0 = false
                showMessageRepair0S = false
                showMessageRepair1 = false
            end
        end)
    end

    if showMessageERefuel0 or showMessageERefuel1 or showMessageERefuel2 or showMessageERefuel3 then
        ui.transparentWindow('TowRefuelMessage', vec2(0 + (uiState.windowSize.x * 0.2), 100), vec2(uiState.windowSize.x / 1.2,uiState.windowSize.y - 100), function ()
            ui.pushFont(ui.Font.Huge)
            if showMessageERefuel0 then
                ui.textAligned('Press [SPACEBAR] for tow truck to bring 5 liters of fuel.', 0, vec2(uiState.windowSize.x,0))
                ui.textAligned('Estimated wait time in minutes is:', 0.1, vec2(uiState.windowSize.x,0))

                ui.setCursorX(uiState.windowSize.x * 0.43)
                ui.setCursorY(80.99)
                ui.text(fueltimewait)
            end
            if showMessageERefuel3 and showMessageERefuelClock + 5 > os.clock() then
                ui.textAligned('Emergency Fuel Canceled', 0.22, vec2(uiState.windowSize.x,0))
            elseif showMessageERefuel2 and showMessageERefuelClock + 5 > os.clock() then
                ui.textAligned('Fuel Delivered!', 0.25, vec2(uiState.windowSize.x,0))
            elseif showMessageERefuel1 then
                ui.textAligned('Tow truck is on the way, please wait in the general area.', 0, vec2(uiState.windowSize.x,0))
                ui.textAligned('DO NOT DISCONNECT FROM THE SERVER.', 0.1, vec2(uiState.windowSize.x,0))

                ui.pushFont(ui.Font.Title)
                ui.textAligned('Press [CTRL] + [SHIFT] + [TAB] to cancel at any time.', 0.22, vec2(uiState.windowSize.x,0))
            end
            if showMessageERefuel3 and showMessageERefuelClock + 5 < os.clock() and showMessageERefuelClock + 10 > os.clock() or showMessageERefuel2 and showMessageERefuelClock + 5 < os.clock() and showMessageERefuelClock + 10 > os.clock() then
                showMessageERefuel3 = false
                showMessageERefuel2 = false
                showMessageERefuel1 = false
            end
        end)
    end

    if showMessageERepair0 or showMessageERepair1 or showMessageERepair2 then
        ui.transparentWindow('TowMessage', vec2(0 + (uiState.windowSize.x * 0.1), 100), vec2(uiState.windowSize.x / 1.1,uiState.windowSize.y - 100), function ()
            ui.pushFont(ui.Font.Huge)
            if showMessageERepair0 then
                ui.textAligned('Do you want a tow? Press [SPACE] to confirm or [CTRL] to cancel.', 0.1, vec2(uiState.windowSize.x,0))
                ui.textAligned('Estimated wait time in minutes is:', 0.25, vec2(uiState.windowSize.x,0))

                ui.setCursorX(uiState.windowSize.x * 0.55)
                ui.setCursorY(80.99)
                ui.text(timewait)
            end
            if showMessageERepair2 and showMessageERepairClock + 5 > os.clock() then
                ui.textAligned('Tow Service Canceled', 0.35, vec2(uiState.windowSize.x,0))
            elseif showMessageERepair1 then
                ui.textAligned('Tow truck is on the way, please wait in the general area.', 0.25, vec2(uiState.windowSize.x,0))
                ui.textAligned('DO NOT DISCONNECT FROM THE SERVER.', 0.31, vec2(uiState.windowSize.x,0))

                ui.pushFont(ui.Font.Title)
                ui.textAligned('Press [CTRL] + [SHIFT] + [TAB] to cancel at any time.', 0.38, vec2(uiState.windowSize.x,0))
            end
            if showMessageERepair2 and showMessageERepairClock + 5 < os.clock() and showMessageERepairClock + 10 > os.clock() then
                showMessageERepair2 = false
                showMessageERepair1 = false
                showMessageERepair0 = false
            end
        end)
    end

    if showMessageToll0 or showMessageToll1 or showMessageToll2 or showMessageToll3 or showMessageToll4 or showMessageToll5 then
        ui.transparentWindow('TollMessage', vec2(0 + (uiState.windowSize.x * 0.1), 100), vec2(uiState.windowSize.x / 1.1,uiState.windowSize.y - 100), function ()
            ui.pushFont(ui.Font.Huge)
            if showMessageToll0 and showMessageTollClock + 5 > os.clock() then
                ui.textAligned('Payment Accepted, Have a Great Day!', 0.35, vec2(uiState.windowSize.x,0))
            elseif showMessageToll0 and showMessageTollClock + 6 < os.clock() then
                showMessageToll0 = false
            elseif showMessageToll3 then
                ui.textAligned('Processing Please Wait...', 0.36, vec2(uiState.windowSize.x,0))
            elseif showMessageToll4 then
                ui.textAligned('Press [SPACE] to Pay the Toll', 0.35, vec2(uiState.windowSize.x,0))
            elseif showMessageToll5 then
                ui.textAligned('Please Stop at the Toll Booth Ahead', 0.33, vec2(uiState.windowSize.x,0))
            end
    
    
            if showMessageToll1 and showMessageTollClock + 5 > os.clock() then
                ui.textAligned('ETC Card Error. Please Back Up and Try Again.', 0.32, vec2(uiState.windowSize.x,0))
            elseif showMessageToll1 and showMessageTollClock + 6 < os.clock() then
                showMessageToll1 = false
            end
            if showMessageToll2 and showMessageTollClock + 5 > os.clock() then
                ui.textAligned('ETC Card Error. Please stop at the toll booth to pay.', 0.25, vec2(uiState.windowSize.x,0))
            elseif showMessageToll2 and showMessageTollClock + 6 < os.clock() then
                showMessageToll2 = false
            end
    
        end)
    end

    if showMessageSecrets0 or showMessageSecrets1 or showMessageSecrets2 then
        ui.transparentWindow('SecretMessage', vec2(0 + (uiState.windowSize.x * 0.1), 100), vec2(uiState.windowSize.x / 1.1,uiState.windowSize.y - 100), function ()
            ui.pushFont(ui.Font.Huge)
            if showMessageSecrets2 and showMessageSecrets + 5 > os.clock() then
                ui.textAligned('You have found all the Secret Locations.', 0.33, vec2(uiState.windowSize.x,0))
                ui.textAligned('Your tow truck timer will always be reduced by 50% now.', 0.28, vec2(uiState.windowSize.x,0))
            elseif showMessageSecrets1 and showMessageSecrets + 5 > os.clock() then
                ui.textAligned('Locations found out of 20:', 0.356, vec2(uiState.windowSize.x,0))
                ui.textAligned(locationSecretNumber, 0.395, vec2(uiState.windowSize.x,0))
            elseif showMessageSecrets0 and showMessageSecrets + 5 > os.clock() then
                ui.textAligned('You found a secret location.', 0.36, vec2(uiState.windowSize.x,0))
                ui.textAligned('Press [SPACE] to claim.', 0.379, vec2(uiState.windowSize.x,0))
            elseif showMessageSecrets + 6 < os.clock() then
                if showMessageSecrets0 or showMessageSecrets1 or showMessageSecrets2 then
                    showMessageSecrets0 = false
                    showMessageSecrets1 = false
                    showMessageSecrets2 = false
                end
            end
        end)
    end


    --ui.transparentWindow('PlayerUI', vec2(0, 0), vec2(500,500), function ()
        --ui.pushFont(ui.Font.Title)

        --ui.textAligned('Hunger', 0.1, vec2(500,100))

        --ui.




    --end)







        if 1 == 2 then

            ui.toolWindow('marketplace', vec2(uiState.windowSize.x / 2 - 350, 100), vec2(700,uiState.windowSize.y - 100), function ()
                ui.pushFont(ui.Font.Title)
                    
                local size = ui.measureText('ScamBook Marketplace')
                ui.setCursorX(ui.getCursorX() + ui.availableSpaceX() / 2 - (size.x / 2))
                ui.setCursorY(40)
                ui.text('ScamBook Marketplace')


                for i=1, 15 do
                    if i == 1 then
                        ui.drawSimpleLine(vec2(0, 0 + (i + 100)), vec2(700, 0 + (i + 100)), uiColor)
                    else
                        ui.drawSimpleLine(vec2(0, 0 + (i * 100)), vec2(700, 0 + (i * 100)), uiColor)
                    end
                    
                end
                    
                ui.setCursorY(120)

                ui.text('Car')

                ui.setCursorY(230)

                ui.text('Car 2')

                ui.popFont()
            end)
        end

end
