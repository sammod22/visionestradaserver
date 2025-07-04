ac.storageSetPath('acs_x86', nil)

DeathPlayerChance = math.randomseed(sim.timeSeconds)
DeathSound0 = ui.MediaPlayer()
DeathSound1 = ui.MediaPlayer()
DeathSound2 = ui.MediaPlayer()
DeathSound0:setSource('http://docs.google.com/uc?export=open&id=1XoeTUqU6TDgo0zk7Xo3ai-oliXvXwhlk'):setAutoPlay(false)
DeathSound1:setSource('http://docs.google.com/uc?export=open&id=1hArZQuTvT1FqEEovr31eNnJm1Swk4_Ce'):setAutoPlay(false)
DeathSound2:setSource('http://docs.google.com/uc?export=open&id=1nB3-hoj4q7vvVxyM4Sse2M4kZmNWL-8X'):setAutoPlay(false)

MusicVolume = 50

Menu0 = ui.MediaPlayer()
Menu1 = ui.MediaPlayer()
Menu2 = ui.MediaPlayer()
Menu3 = ui.MediaPlayer()
Menu4 = ui.MediaPlayer()
Menugtauto = ui.MediaPlayer()

Menu0:setSource('http://docs.google.com/uc?export=open&id=1PH9x-cIfdWAVAwhNu5UZ3ot_qjpuc5SM'):setAutoPlay(false):setVolume(MusicVolume * 0.01)
Menu1:setSource('http://docs.google.com/uc?export=open&id=1jmxdfUgmyaqPwPa8r5kRSvyodK-WXsi5'):setAutoPlay(false):setVolume(MusicVolume * 0.01)
Menu2:setSource('http://docs.google.com/uc?export=open&id=1k30QEjvpcCHUwfwYAmWBk53q-U1NyMer'):setAutoPlay(false):setVolume(MusicVolume * 0.01)
Menu3:setSource('http://docs.google.com/uc?export=open&id=1fmkhiTqETSKN1HwZUQ-aSJhy16IXw3g9'):setAutoPlay(false):setVolume(MusicVolume * 0.01)
Menu4:setSource('http://docs.google.com/uc?export=open&id=1LIwvs6XHvIUgkU8BZ0Kfk5F_82BZI_BC'):setAutoPlay(false):setVolume(MusicVolume * 0.01)
Menugtauto:setSource('http://docs.google.com/uc?export=open&id=1-B7imrBnQkEkMo6SFJSESCZ88_jviiUl'):setAutoPlay(false):setVolume(MusicVolume * 0.01)

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
local deathDetectorTimer = os.clock()
local deathDetectorSpeed = 0

local counter = 0
local waterAdjuster = 0

local gforces = 0
local blown = 0

local died = 0
local diedTime = os.clock()
local mortal = true
local money = 30000
local moneyTransfer = 0
local moneyRecieved = 0
local confirmCarPurchase = false

local fuel = 10
local oilAmount = 100
local oilQuality = 100
local oilColor

local tempEnabled = 0

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

function StorageUnpack(data,items,isnumber) --since ac storage doesn't support tables, this is a function that unpacks a string into a table, so it can be used
    local storedVals = {}
    for i=1,items do
        if isnumber then
            storedVals[i] = tonumber(string.split(data,'/')[i])
        else
            storedVals[i] = string.split(data,'/')[i]
        end
    end
    return storedVals
end

function StorageUnpackUsedMarketNested(data,items) --same thing but with nested tables
    local storedVals = {{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{}}
    local k = 1 --just a simple iterator over the string
    for i=1,50 do
        for j=0,3 do
            storedVals[i][j] = string.split(data,'/')[k]
            k = k+1
        end
    end
    return storedVals
end

function StorageUnpackCarCollectionNested(data,items) --same thing but with nested tables
    local storedVals = {}
    local k = 1 --just a simple iterator over the string
    for i=0,items - 1 do
        storedVals [i] = {}
        for j=0,3 do
            storedVals[i][j] = string.split(data,'/')[k]
            k = k+1
        end
    end
    return storedVals
end

function StorageUnpackCarModificationsNested(data,cars,carsmodAmount) --same thing but with nested tables
    local storedVals = {}
    local k = 1 --just a simple iterator over the string
    for i=1,cars do
        storedVals [i] = {}
        for j=1, tonumber(carsmodAmount[i]) do
            storedVals[i][j] = string.split(data,'/')[k]
            k = k+1
        end
    end
    return storedVals
end

function StorageUnpackCarModificationsAmountNested(data,cars) --same thing but with nested tables
    local storedVals = {}
    local k = 1 --just a simple iterator over the string
    for i=1,cars do
        storedVals[i] = string.split(data,'/')[k]
        k = k+1
    end
    return storedVals
end

function StorageUnpackCarStatsNested(data,items) --same thing but with nested tables
    local storedVals = {}
    local k = 1 --just a simple iterator over the string
    for i=1,items do
        storedVals [i] = {}
        for j=1,9 do
            storedVals[i][j] = string.split(data,'/')[k]
            k = k+1
        end
    end
    return storedVals
end

function StoragePack(data) --prepairing string to store
    local storedString = ""
    for i=1, #data do
        storedString = storedString .. data[i]
        if i ~= #data then
            storedString = storedString .. "/"  
        end
    end
    return storedString
end

function StoragePackUsedMarketNested(data) --same thing but with nested tables
    local storedString = ""
    for i=1, 50 do
        for j=0,3 do
            storedString = storedString .. data[i][j]
            if i*j ~= 200 then --eh, it works
                storedString = storedString .. "/" 
            end
        end
    end
    return storedString
end

function StoragePackCarCollectionNested(data,items) --same thing but with nested tables
    local storedString = ""
    for i=0, items - 1 do
        for j=0,3 do
            storedString = storedString .. data[i][j]
            if i*j ~= 200 then --eh, it works
                storedString = storedString .. "/" 
            end
        end
    end
    return storedString
end

function StoragePackCarModificationsNested(data,cars) --same thing but with nested tables
    local storedString = ""
    for i=1, cars do
        for j=1, #data[i] do
            storedString = storedString .. data[i][j]
            if i*j ~= 200 then --eh, it works
                storedString = storedString .. "/" 
            end
        end
    end
    return storedString
end

function StoragePackCarModificationsAmountNested(data,cars)
    local storedString = ""
    for i=1, cars do
        storedString = storedString .. tostring(#data[i])
        if i ~= #data then --eh, it works
            storedString = storedString .. "/" 
        end
    end
    return storedString
end

function StoragePackCarStatsNested(data,items) --same thing but with nested tables
    local storedString = ""
    for i=1, items do
        for j=1,9 do
            storedString = storedString .. data[i][j]
            if i*j ~= 200 then --eh, it works
                storedString = storedString .. "/" 
            end
        end
    end
    return storedString
end

local storedValues = ac.storage{
    carStatsAmount = 0,
    carStats = '',
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
    tempEnabled = 0,
    usedMarket = '',
    tableCount = -1,
    usedMarketExpires = '',
    carCollectionAmount = 0,
    carCollection = '',
    carCollectionState = '',
    carModifications = '',
    carModificationsAmount = '',
    MusicVolume = 50
}

--- TIRE ARRAY KEY ---
--- 
--- NAME, AMOUNT OF SIZES, SIZE

local tireArray = {

-- BRIDGESTONE --

{'Bridgestone Potenza RE050A', 17, '205/45/R17', 400, '235/40/ZR18', 1150, '245/45/R18', 1150, '265/40/ZR18', 1500, '235/35/ZR19', 1300, '235/40/R19', 1350, '235/40/ZR19', 1300, '245/40/R19', 1300, '245/40/ZR19', 1350, '265/35/ZR19', 1650, '265/35/R19', 1450, '275/35/R19', 1500, '285/35/ZR19', 1650, '285/40/ZR19', 1700, '295/30/ZR19', 1550, '305/30/ZR19', 1800, '285/35/R20', 1750},
{'Bridgestone Potenza RE050A RFT', 9, '205/45/R17', 1050, '215/40/R18', 1500, '245/35/R18', 1200, '225/35/R19', 1500, '245/40/R19', 1700, '255/30/R19', 1550, '275/35/R19', 1800, '245/35/R20', 1350, '275/30/R20', 1750},
{'Bridgestone Potenza S001', 13, '205/45/R17', 850, '225/35/R18', 750, '225/40/R18', 650, '245/35/R18', 600, '245/40/R18', 950, '245/35/R19', 1200, '255/35/R19', 900, '215/45/R20', 1700, '245/40/R20', 1450, '245/40/ZR20', 1350, '255/35/R20', 1650, '275/30/R20', 1550, '295/35/ZR20', 2000},

{'Bridgestone Potenza RE-01R', 21, '195/50/R15', 700, '205/45/R16', 750, '205/55/R16', 900, '225/50/R16', 900, '205/45/R17', 950, '215/45/R17', 1100, '225/45/R17', 1200, '235/40/R17', 1050, '235/45/R17', 1300, '245/40/R17', 1100, '245/45/R17', 1450, '255/40/R17', 1150, '225/40/R18', 1300, '235/40/R18', 1600, '245/40/R18', 1400, '245/45/R18', 1300, '255/35/R18', 1950, '255/45/R18', 1900, '265/35/R18', 1800, '245/35/R19', 1650, '275/30/R19', 1850},
{'Bridgestone Potenza RE-71R', 44, '195/50/R15', 550, '205/50/R15', 600, '195/55/R16', 600, '205/45/R16', 650, '205/50/R16', 650, '205/55/R16', 700, '225/50/R16', 700, '205/45/R17', 750, '215/45/R17', 600, '225/45/R17', 700, '235/45/R17', 650, '245/40/R17', 800, '245/45/R17', 700, '255/40/R17', 850, '215/40/R18', 800, '215/45/R18', 800, '225/40/R18', 850, '225/45/R18', 950, '225/50/R18', 800, '235/40/R18', 1050, '235/45/R18', 800, '245/40/R18', 1000, '245/45/R18', 900, '255/35/R18', 1100, '255/40/R18', 950, '265/35/R18', 1250, '265/45/R18', 1150, '275/35/R18', 1250, '285/30/R18', 1350, '225/35/R19', 1100, '235/35/R19', 1200, '235/40/R19', 900, '245/35/R19', 1150, '245/40/R19', 1100, '255/35/R19', 1200, '265/35/R19', 1250, '265/40/R19', 1200, '275/35/R19', 1400, '285/35/R19', 1400, '305/30/R19', 1650, '245/35/R20', 1350, '255/40/R20', 1150, '285/35/R20', 1350, '295/30/R20', 1750},
{'Bridgestone Potenza RE-71RS', 41, '205/50/R15', 800, '225/50/R15', 950, '195/50/R16', 950, '195/55/R16', 700, '205/45/R16', 1000, '205/50/R16', 950, '205/55/R16', 950, '215/45/R16', 1050, '225/50/R16', 800, '205/45/R17', 1050, '215/45/R17', 1050, '225/45/R17', 1100, '235/45/R17', 1100, '245/40/R17', 1100, '245/45/R17', 1100, '255/40/R17', 1150, '215/40/R18', 1200, '215/45/R18', 800, '225/40/R18', 1050, '225/45/R18', 1000, '225/50/R18', 1050, '235/40/R18', 1100, '245/40/R18', 1100, '245/45/R18', 1250, '255/35/R18', 1350, '255/40/R18', 1100, '265/35/R18', 1500, '275/35/R18', 1600, '285/30/R18', 1450, '295/30/R18', 1600, '295/35/R18', 1700, '235/35/R19', 1300, '235/40/R19', 1250, '245/35/R19', 1350, '245/40/R19', 1300, '255/35/R19', 1400, '265/35/R19', 1500, '275/35/R19', 1550, '285/35/R19', 1650, '305/30/R19', 1750, '285/35/R20', 1800},
{'Bridgestone Potenza RE-11S', 15, '185/60/R14', 1150, '185/55/R15', 650, '195/50/R15', 650, '195/55/R15', 650, '205/50/R15', 1150, '205/60/R15', 1250, '225/50/R15', 1150, '225/45/R16', 1450, '225/50/R16', 1450, '215/45/R17', 1850, '225/45/R17', 1900, '235/45/R17', 1950, '245/40/R18', 2400, '265/35/R18', 2800, '295/35/R18', 3200},

-- CONTINENTAL --

-- DUNLOP --

{'Dunlop SP Sport Maxx GT600 DSST CTT NR1', 2, '255/40/ZRF20', 2050, '285/35/ZRF20', 2250},

-- FALKEN --

-- GOODYEAR --

-- MICHELIN --

{'Michelin Primacy HP', 1, '245/40/R17', 1000},

{'Michelin Pilot Sport 2', 18, '205/55/R17', 1200, '225/45/ZR17', 1050, '235/50/ZR17', 1250, '255/40/ZR17', 1500, '225/40/ZR18', 1100, '235/40/ZR18', 1050, '265/35/ZR18', 1450, '265/40/ZR18', 1550, '285/30/ZR18', 2050, '295/30/ZR18', 1950, '295/35/ZR18', 2300, '235/35/ZR19', 1450, '255/40/ZR19', 1600, '265/35/ZR19', 1700, '295/30/ZR19', 1950, '305/30/ZR19', 2100, '275/45/ZR20', 2050},
{'Michelin Pilot Sport 4', 28, '205/55/ZR16', 750, '205/40/ZR18', 1000, '215/40/R18', 1050, '225/40/ZR18', 800, '235/40/ZR18', 950, '235/45/ZR18', 1000, '245/40/ZR18', 950, '225/40/ZR19', 1100, '225/55/R19', 1100, '235/45/ZR19', 1150, '245/40/R19', 1250, '245/45/ZR19', 1350, '245/45/R19', 1300, '255/35/ZR19', 1150, '255/40/R19', 1350, '255/45/R19', 1350, '265/45/ZR19', 1500, '275/40/ZR19', 1550, '275/45/R19', 1600, '295/40/ZR19', 1550, '245/45/R20', 1350, '255/40/R20', 1600, '275/40/ZR20', 1500, '285/40/R20', 1700, '315/35/ZR20', 2500, '275/35/ZR21', 2100, '315/30/ZR21', 2500, '325/30/ZR21', 2200},
{'Michelin Pilot Sport 4 S', 1, '', 0},
{'Michelin Pilot Super Sport', 39, '225/40/ZR18', 900, '225/45/ZR18', 1150, '245/35/ZR18', 1100, '245/40/ZR18', 1000, '255/40/ZR18', 1100, '265/40/ZR18', 1400, '275/40/ZR18', 1350, '285/35/ZR18', 1550, '295/35/ZR18', 1800, '245/35/ZR19', 1250, '255/35/ZR19', 1250, '255/45/ZR19', 1450, '265/35/ZR19', 1550, '265/40/ZR19', 1500, '275/35/ZR19', 1500, '285/30/ZR19', 1750, '285/40/ZR19', 1800, '295/35/ZR19', 1650, '305/35/ZR19', 1750, '245/35/ZR20', 1800, '245/35/R20', 1700, '245/40/ZR20', 1500, '255/40/ZR20', 1350, '265/30/ZR20', 1500, '265/35/ZR20', 1700, '275/30/R20', 1800, '275/35/ZR20', 1550, '285/30/ZR20', 1700, '295/30/ZR20', 1650, '295/35/ZR20', 1850, '305/30/ZR20', 2050, '315/35/ZR20', 2250, '335/30/ZR20', 2150, '245/35/ZR21', 1700, '285/35/ZR21', 1850, '325/30/ZR21', 2000, '275/35/ZR22', 2150, '305/30/ZR22', 2300, '305/35/ZR22', 2500},
{'Michelin Pilot Super Sport ZP', 9, '245/40/ZR18', 1300, '245/35/ZR19', 1450, '285/30/ZR19', 1900, '285/35/ZR19', 1650, '285/30/ZR20', 1800, '335/25/ZR20', 2350, '245/35/ZR21', 1900, '245/40/RF21', 2100, '275/35/RF21', 2150},

{'Michelin Pilot Sport Cup 2', 1, '', 0},
{'Michelin Pilot Sport Cup 2 R', 1, '', 0},

-- NANKANG --

-- NITTO --

-- PIRELLI --

{'Pirelli P Zero', 96, '205/45/ZR17', 850, '205/40/ZR18', 1050, '225/40/ZR18', 750, '235/40/ZR18', 850, '235/50/ZR18', 1050, '245/35/ZR18', 950, '245/40/R18', 1050, '245/50/ZR18', 1300, '255/40/R18', 1250, '265/35/R18', 1100, '275/45/ZR18', 1500, '285/35/R18', 1200, '225/35/R19', 1200, '235/35/ZR19', 1300, '235/55/R19', 1150, '245/35/ZR19', 1450, '245/40/ZR19', 1250, '245/45/R19', 1250, '245/45/ZR19', 1400, '255/30/ZR19', 1150, '255/35/R19', 1150, '255/35/ZR19', 1450, '255/40/R19', 1350, '255/40/ZR19', 1200, '255/45/ZR19', 1550, '255/45/R19', 1450, '255/50/R19', 1400, '255/55/R19', 1150, '265/35/ZR19', 1650, '265/50/R19', 1550, '275/30/R19', 1300, '275/40/ZR19', 1600, '285/30/ZR19', 1750, '285/35/ZR19', 1500, '285/40/ZR19', 1900, '295/30/ZR19', 2000, '295/45/R19', 1800, '305/30/ZR19', 1900, '235/35/ZR20', 1400, '235/35/R20', 1450, '235/45/R20', 1250,
'245/30/ZR20', 1850, '245/35/ZR20', 1650, '245/40/R20', 1500, '245/45/ZR20', 1300, '255/30/ZR20', 1650, '255/35/ZR20', 1250, '255/40/R20', 1450, '255/40/ZR20', 1450, '255/50/R20', 1150, '265/30/R20', 1850, '265/35/R20', 1500, '265/35/ZR20', 1700, '265/45/R20', 1700, '265/45/ZR20', 1600, '275/30/ZR20', 1750, '275/35/ZR20', 1650, '275/40/ZR20', 1350, '275/45/ZR20', 1650, '285/30/ZR20', 1700, '285/35/ZR20', 1950, '285/40/R20', 1950, '295/30/ZR20', 1750, '295/35/ZR20', 2100, '295/40/R20', 1650, '305/30/ZR20', 2200, '305/35/ZR20', 1050, '305/40/ZR20', 2300, '315/35/ZR20', 2300, '325/35/R20', 2600, '335/30/ZR20', 1300, '345/25/ZR20', 3150,
'255/30/ZR21', 1950, '255/40/R21', 1750, '265/40/ZR21', 1700, '265/40/R21', 1550, '265/45/R21', 1850, '275/30/ZR21', 2000, '275/35/ZR21', 2000, '285/30/ZR21', 2050, '285/40/ZR21', 2050, '285/45/ZR21', 2650, '295/35/ZR21', 1750, '295/35/R21', 1750, '295/40/ZR21', 1750, '315/35/ZR21', 2300, '325/25/ZR21', 2250, '355/25/ZR21', 2450, '265/40/R22', 1750, '275/40/R22', 1950, '285/35/ZR22', 2100, '285/40/ZR22', 2950, '285/40/R22', 2100, '315/30/ZR22', 2800, '325/35/R22', 2200, '335/25/ZR22', 2900},

-- TOYO --

{'Toyo Proxes RA1', 1, '', 0},
{'Toyo Proxes R888', 1, '', 0},
{'Toyo Proxes R888R', 1, '', 0},
{'Toyo Proxes RR', 1, '', 0},

-- VALINO --

{'Valino Greeva 08D', 8, '205/50/R15', 650, '215/40/R17', 700, '215/45/R17', 700, '235/40/R17', 700, '215/35/R18', 750, '235/40/R18', 800, '255/35/R18', 900, '265/35/R18', 950},

-- YOKOHAMA --

{'Yokohama Advan Fleva V701', 7, '205/50/R15', 500, '195/55/R16', 550, '225/50/R17', 400, '215/45/R18', 800, '225/35/R18', 800, '265/30/R19', 950, '255/30/R20', 900},
{'Yokohama Advan Sport V107', 7, '245/40/ZR18', 950, '235/40/ZR19', 1250, '235/35/ZR20', 1400, '245/35/ZR20', 1450, '255/50/R20', 1750, '295/30/ZR20', 800, '305/35/R23', 1800},
{'Yokohama Advan Sport V105', 17, '195/50/R16', 1000, '225/45/R17', 1350, '235/40/ZR19', 1300, '245/40/ZR19', 1450, '265/40/ZR19', 1700, '275/35/ZR19', 1700, '275/40/ZR19', 2000, '285/40/ZR19', 2050, '295/35/ZR19', 1750, '255/30/ZR20', 1500, '255/40/ZR20', 1900, '275/30/ZR20', 900, '295/35/ZR20', 2150, '315/35/ZR20', 2650, '295/35/R21', 1950, '285/35/ZR22', 1650, '315/30/ZR22', 2100},
{'Yokohama Advan Apex V601', 17, '225/45/R17', 650, '235/50/R18', 450, '255/35/R18', 850, '265/35/R18', 850, '275/35/R18', 950, '275/40/R18', 1050, '245/35/R19', 1000, '265/35/R19', 1100, '285/30/R19', 1150, '295/30/R19', 1150, '305/30/R19', 1250, '325/30/R19', 1300, '235/35/R20', 1100, '275/35/R20', 1300, '305/35/R20', 1650, '245/35/R21', 1150, '265/35/R21', 1300},

{'Yokohama Advan Neova AD07 LTS', 2, '175/55/R16', 750, '225/45/R17', 1000},
{'Yokohama Advan Neova AD08 R', 37, '205/50/R15', 750, '205/55/R16', 1050, '225/50/R16', 1150, '205/45/R17', 1200, '205/50/R17', 1050, '215/40/R17', 1000, '215/45/R17', 1250, '225/45/R17', 1300, '235/40/R17', 1400, '235/45/R17', 1400, '245/40/R17', 1450, '245/45/R17', 1450, '255/40/R17', 1250, '215/45/R18', 1450, '225/40/R18', 1350, '225/45/R18', 1300, '235/40/R18', 1650, '245/40/R18', 1350, '245/45/R18', 1700, '255/35/R18', 2000, '255/40/R18', 1900, '265/35/R18', 1850, '265/40/R18', 1400, '285/30/R18', 2150, '295/30/R18', 2250, '225/35/R19', 1800, '235/35/R19', 1800, '245/35/R19', 1750, '245/40/R19', 1700, '255/30/R19', 1950, '255/35/R19', 1800, '265/30/R19', 1450, '265/35/R19', 1800, '275/30/R19', 1900, '275/35/R19', 1850, '295/30/R19', 2100, '305/30/R19', 2100},
{'Yokohama Advan Neova AD09', 48, '205/50/R15', 650, '205/45/R16', 700, '205/50/R16', 750, '205/55/R16', 850, '225/50/R16', 900, '205/45/R17', 800, '205/50/R17', 950, '215/40/R17', 1000, '215/45/R17', 950, '225/45/R17', 900, '225/50/R17', 1000, '235/45/R17', 900, '245/40/R17', 1050, '245/45/R17', 1100, '255/40/R17', 1150, '225/40/R18', 1050, '225/45/R18', 1150, '235/40/R18', 1150, '245/35/R18', 1250, '245/40/R18', 1150, '245/45/R18', 1350, '255/35/R18', 1500, '255/40/R18', 1200, '265/35/R18', 1400, '265/40/R18', 1500, '275/40/R18', 1500, '285/30/R18', 1650, '295/30/R18', 1650, '295/35/R18', 1750, '225/35/R19', 1150, '225/40/R19', 1150, '235/35/R19', 1300, '235/40/R19', 1050, '245/35/R19', 1400, '245/40/R19', 1200, '255/30/R19', 1300, '255/35/R19', 1450, '255/40/R19', 1400, '265/35/R19', 1450, '275/35/R19', 1600, '275/40/R19', 1600, '285/35/R19', 1650,
'295/30/R19', 1550, '325/30/R19', 1700, '235/35/R20', 1450, '245/30/R20', 1400, '245/35/R20', 1300, '245/40/R20', 1300, '255/35/R20', 1750, '255/40/R20', 1250, '265/30/R20', 1250, '265/35/R20', 1450, '275/30/R20', 1400, '275/35/R20', 1550, '285/30/R20', 1700, '285/35/R20', 1700, '295/30/R20', 1650, '295/35/R20', 1900, '305/30/R20', 1800, '305/30/R21', 1700, '325/30/R21', 1750},

{'Yokohama Advan A052', 38, '185/55/R14', 800, '195/50/R15', 850, '195/55/R15', 900, '205/50/R15', 800, '225/50/R15', 1050, '195/45/R16', 950, '195/50/R16', 1050, '205/50/R16', 1050, '205/55/R16', 1050, '225/45/R16', 1100, '225/50/R16', 900, '245/45/R16', 1100, '205/40/R17', 1100, '205/45/R17', 1050, '215/40/R17', 1100, '215/45/R17', 1050, '225/45/R17', 1050, '235/45/R17', 1150, '245/40/R17', 1100, '255/40/R17', 1100, '225/35/R18', 1250, '225/40/R18', 1100, '235/40/R18', 1300, '235/45/R18', 1250, '245/40/R18', 1250, '255/35/R18', 1500, '255/40/R18', 1300, '265/35/R18', 1550, '265/40/R18', 1550, '265/45/R18', 1300, '275/40/R18', 1500, '295/30/R18', 1700, '295/35/R18', 1850, '315/30/R18', 2050, '235/40/ZR19', 1150, '245/35/ZR19', 1500, '255/35/ZR19', 1300, '265/40/ZR19', 1350, '275/35/ZR19', 1400, '295/35/R19', 1750, '245/30/ZR20', 1700, '245/35/ZR20', 1450, '255/40/ZR20', 1450, '285/35/ZR20', 1900, '295/30/R20', 1850},
{'Yokohama Advan A050 M', 20, '175/60/R13', 350, '185/55/R14', 400, '185/60/R14', 650, '165/50/R15', 650, '195/50/R15', 850, '205/50/R15', 750, '215/50/R15', 1100, '225/50/R15', 1100, '205/50/R16', 1000, '225/45/R16', 1250, '215/45/R17', 950, '235/45/R17', 1550, '245/40/R17', 1650, '255/40/R17', 1400, '235/40/R18', 1900, '245/40/R18', 2050, '255/40/R18', 2150, '265/35/R18', 1650, '295/30/R18', 2000, '295/35/R18', 2450},
{'Yokohama Advan A050 GS', 15, '185/55/R14', 400, '185/60/R14', 650, '195/50/R15', 900, '195/55/R15', 800, '205/50/R15', 900, '215/50/R15', 1100, '225/50/R15', 1050, '205/50/R16', 1050, '225/45/ZR17', 2150, '235/45/ZR17', 1550, '255/40/ZR17', 1700, '235/40/ZR18', 1900, '245/40/ZR18', 1900, '295/30/ZR18', 2700, '295/35/ZR18', 1850},
{'Yokohama Advan A050 G2S', 10, '185/55/R14', 400, '185/60/R14', 650, '195/50/R15', 900, '195/55/R15', 800, '205/50/R15', 900, '215/50/R15', 1100, '225/45/ZR17', 1400, '235/45/ZR17', 1550, '255/40/ZR17', 1700, '245/40/ZR18', 2000}

}

local usedMarket = {}
local usedMarketExpires = {}

local carCollectionAmount = 0
local carCollection = {}
local carCollectionState = {}
local carModifications = {}
local carModificationsAmount = {}

CarStats = {}
CarStatsAmount = 0
CarStatsSelected = 1
CarStatsFoundMatch = false

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

{'1999 Honda S2000 (AP1)', 'Manual', 15000, 40000, 18, 6, 'Silverstone Metallic', 36, 'Monte Carlo Blue Pearl', 8, 'Grand Prix White', 15, 'Indy Yellow Pearl', 21, 'New Formula Red', 15, 'Berlina Black', 16},
{'2001 Honda S2000 (AP1)', 'Manual', 15000, 40000, 20, 13, 'Silverstone Metallic', 17, 'Midnight Pearl', 2, 'Monte Carlo Blue Pearl', 10, 'Grand Prix White', 15, 'Indy Yellow Pearl', 7, 'New Formula Red', 6, 'Berlina Black', 12, 'Nurburgring Blue Pearl', 2, 'Plantinum White Pearl', 2, 'Sebring Silver Metallic', 25, 'New Imola Orange Pearl', 3, 'Lime Green Metallic', 2, 'Monza Red Pearl', 2},
{'2004 Honda S2000 (AP1)', 'Manual', 20000, 45000, 15, 13, 'Moon Rock Metallic', 3, 'Silverstone Metallic', 13, 'Sebring Silver Metallic', 16, 'Nurburgring Blue Metallic', 5, 'Royal Navy Blue Pearl', 5, 'Lime Green Metallic', 2, 'New Indy Yellow Pearl', 8, 'New Imola Orange Pearl', 5, 'New Formula Red', 8, 'Monza Red Pearl', 2, 'Platinum White Pearl', 2, 'Grand Prix White', 18, 'Berlina Black', 13},
{'2006 Honda S2000 (AP2)', 'Manual', 20000, 45000, 11, 11, 'Grand Prix White', 14, 'Sebring Silver Metallic', 14, 'Silverstone Metallic', 19, 'Moon Rock Metallic', 2, 'Deep Burgundy Metallic', 5, 'Berlina Black', 13, 'Royal Navy Blue Pearl', 11, 'Nurburgring Blue Pearl', 7, 'Bermuda Blue Pearl', 2, 'New Indy Yellow Pearl', 8, 'New Formula Red', 10},
{'2008 Honda S2000 (AP2)', 'Manual', 25000, 55000, 7, 9, 'Grand Prix White', 15, 'New Indy Yellow Pearl', 10, 'New Formula Red', 12, 'Synchro Silver Metallic', 25, 'Moon Rock Metallic', 4, 'Bermuda Blue Pearl', 3, 'Berlina Black', 18, 'Plantinum White Pearl', 4, 'Premium Sunset Mauve Pearl', 9},

--- MAZDA ---

{'1989 Eunos Roadster (NA)', 'Manual', 10000, 30000, 1, 4, 'Classic Red', 57, 'Crystal White', 24, 'Silver Stone Metallic Red', 1, 'Mariner Blue', 13},
{'1989 Eunos Roadster (NA) [Special Package]', 'Manual', 6000, 20000, 29, 4, 'Classic Red', 47, 'Crystal White', 24, 'Silver Stone Metallic Red', 12, 'Mariner Blue', 10},
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

--{'1996 Mitsubishi Lancer GSR Evolution IV', 'Manual', 10000, 30000, 22, 5, 'Scotia White', 50, 'Steel Silver', 15, 'Pyrenees Black', 17, 'Palma Red', 7, 'Icecelle Blue', 15},
--{'1996 Mitsubishi Lancer RS Evolution IV', 'Manual', 15000, 40000, 5, 1, 'Scotia White', 1},
{'1998 Mitsubishi Lancer GSR Evolution V', 'Manual', 20000, 40000, 13, 5, 'Scotia White', 50, 'Satellite Silver', 15, 'Pyrenees Black', 17, 'Palma Red', 7, 'Dandelion Yellow', 15},
{'1998 Mitsubishi Lancer RS Evolution V', 'Manual', 25000, 70000, 3, 1, 'Scotia White', 1},
{'1999 Mitsubishi Lancer GSR Evolution VI', 'Manual', 15000, 35000, 13, 5, 'Scotia White', 45, 'Satellite Silver', 15, 'Pyrenees Black', 15, 'Lance Blue', 10, 'Icecelle Blue', 15},
{'1999 Mitsubishi Lancer RS Evolution VI', 'Manual', 25000, 70000, 3, 1, 'Scotia White', 1},
{'2000 Mitsubishi Lancer GSR Evolution VI Tommi Makinen Edition', 'Manual', 30000, 80000, 7, 5, 'Scotia White', 47, 'Satellite Silver', 17, 'Pyrenees Black', 10, 'Canal Blue', 19, 'Passion Red', 6},
{'2000 Mitsubishi Lancer GSR Evolution VI Tommi Makinen Edition Special Color Package', 'Manual', 40000, 220000, 3, 1, 'Passion Red', 1},
{'2000 Mitsubishi Lancer RS Evolution VI Tommi Makinen Edition', 'Manual', 25000, 70000, 2, 1, 'Scotia White', 1},

{'2003 Mitsubishi Lancer Evolution VIII GSR', 'Manual', 15000, 30000, 11, 6, 'Red Solid', 8, 'Yellow Solid', 6, 'Medium Purple Mica', 7, 'White Solid', 35, 'Cool Silver Metallic', 26, 'Black Mica', 20},
{'2003 Mitsubishi Lancer Evolution VIII RS [5M/T]', 'Manual', 35000, 65000, 3, 1, 'White Solid', 1},
{'2003 Mitsubishi Lancer Evolution VIII RS [6M/T]', 'Manual', 50000, 120000, 1, 1, 'White Solid', 1},
{'2004 Mitsubishi Lancer Evolution VIII MR GSR', 'Manual', 15000, 35000, 3, 4, 'Medium Purplish Gray Mica', 48, 'Cool Silver Metallic', 21, 'White Pearl', 24, 'Red Solid', 7},
{'2004 Mitsubishi Lancer Evolution VIII MR GSR [Manufacturer Options]', 'Manual', 15000, 35000, 5, 4, 'Medium Purplish Gray Mica', 48, 'Cool Silver Metallic', 21, 'White Pearl', 24, 'Red Solid', 7},
{'2004 Mitsubishi Lancer Evolution VIII MR RS [5M/T]', 'Manual', 50000, 80000, 2, 1, 'White Solid', 1},
{'2004 Mitsubishi Lancer Evolution VIII MR RS [6M/T]', 'Manual', 70000, 150000, 1, 1, 'White Solid', 1},
{'2005 Mitsubishi Lancer Evolution IX GSR', 'Manual', 20000, 50000, 9, 6, 'White Solid', 30, 'Yellow Solid', 4, 'Red Solid', 7, 'Blue Mica', 13, 'Black Mica', 20, 'Cool Silver Metallic', 26},
{'2005 Mitsubishi Lancer Evolution IX GT', 'Manual', 20000, 50000, 5, 6, 'White Solid', 38, 'Yellow Solid', 6, 'Red Solid', 10, 'Blue Mica', 12, 'Black Mica', 13, 'Cool Silver Metallic', 21},
{'2005 Mitsubishi Lancer Evolution IX RS', 'Manual', 40000, 70000, 3, 1, 'White Solid', 1},
{'2006 Mitsubishi Lancer Evolution IX MR GSR', 'Manual', 25000, 55000, 2, 4, 'White Pearl', 35, 'Cool Silver Metallic', 14, 'Medium Purplish Gray Mica', 40, 'Red Solid', 11},
{'2006 Mitsubishi Lancer Evolution IX MR GSR [Manufacturer Options]', 'Manual', 25000, 55000, 3, 4, 'White Pearl', 35, 'Cool Silver Metallic', 14, 'Medium Purplish Gray Mica', 40, 'Red Solid', 11},
{'2006 Mitsubishi Lancer Evolution IX MR RS', 'Manual', 60000, 90000, 3, 2, 'White Solid', 81, 'Red Solid', 19},

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

{'1999 Nissan Silvia Spec-R (S15)', 'Manual', 20000, 50000, 17, 7, 'Sparkling Silver', 27, 'Brilliant Blue', 15, 'Pearl White', 44, 'Light Blueish Silver', 1, 'Lightning Yellow', 2, 'Active Red', 4, 'Super Black', 8},
{'1999 Nissan Silvia Spec-R (S15)', 'Automatic', 17000, 40000, 3, 7, 'Sparkling Silver', 27, 'Brilliant Blue', 15, 'Pearl White', 44, 'Light Blueish Silver', 1, 'Lightning Yellow', 2, 'Active Red', 4, 'Super Black', 8},
{'1999 Nissan Silvia Spec-R Aero SUPER HICAS (S15)', 'Manual', 25000, 50000, 4, 7, 'Sparkling Silver', 30, 'Brilliant Blue', 13, 'Pearl White', 40, 'Light Blueish Silver', 1, 'Lightning Yellow', 3, 'Active Red', 4, 'Super Black', 10},
{'1999 Nissan Silvia Spec-R Aero (S15)', 'Manual', 25000, 50000, 7, 7, 'Sparkling Silver', 25, 'Brilliant Blue', 13, 'Pearl White', 44, 'Light Blueish Silver', 1, 'Lightning Yellow', 4, 'Active Red', 4, 'Super Black', 10},
{'1999 Nissan Silvia Spec-S (S15)', 'Manual', 15000, 35000, 5, 7, 'Sparkling Silver', 41, 'Brilliant Blue', 13, 'Pearl White', 30, 'Light Blueish Silver', 1, 'Lightning Yellow', 2, 'Active Red', 6, 'Super Black', 8},
{'1999 Nissan Silvia Spec-S (S15)', 'Automatic', 10000, 30000, 2, 7, 'Sparkling Silver', 41, 'Brilliant Blue', 13, 'Pearl White', 30, 'Light Blueish Silver', 1, 'Lightning Yellow', 2, 'Active Red', 6, 'Super Black', 8},
{'1999 Nissan Silvia Spec-S Aero (S15)', 'Manual', 20000, 35000, 6, 7, 'Sparkling Silver', 28, 'Brilliant Blue', 12, 'Pearl White', 43, 'Light Blueish Silver', 1, 'Lightning Yellow', 2, 'Active Red', 4, 'Super Black', 10},
{'2002 Nissan Silvia Spec-R Aero (S15)', 'Manual', 25000, 50000, 5, 6, 'Sparkling Silver', 25, 'Brilliant Blue', 13, 'Pearl White', 44, 'Lightning Yellow', 4, 'Active Red', 4, 'Super Black', 10},
{'2002 Nissan Silvia Spec-R V Package (S15)', 'Manual', 20000, 60000, 7, 6, 'Sparkling Silver', 24, 'Brilliant Blue', 24, 'Pearl White', 51, 'Lightning Yellow', 1, 'Active Red', 1, 'Super Black', 1},
{'2002 Nissan Silvia Spec-S Aero (S15)', 'Manual', 20000, 35000, 3, 6, 'Sparkling Silver', 28, 'Brilliant Blue', 12, 'Pearl White', 43, 'Lightning Yellow', 2, 'Active Red', 4, 'Super Black', 10},
{'2002 Nissan Silvia Spec-S V Package (S15)', 'Manual', 15000, 30000, 4, 6, 'Sparkling Silver', 37, 'Brilliant Blue', 22, 'Pearl White', 41, 'Lightning Yellow', 1, 'Active Red', 1, 'Super Black', 1},

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
{'1997 Subaru Impreza Sedan WRX Pure Sports Sedan (GC8)', 'Manual', 6000, 25000, 7, 5, 'Active Red', 3, 'Feather White', 52, 'Light Silver Metallic', 21, 'Black Mica', 10, 'Dark Blue Mica', 14},
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

{'1983 Toyota Corolla Levin 3door GT-APEX (AE86)', 'Manual', 15000, 45000, 25, 3, 'High Metal Two-Tone', 25, 'High Tech Two-Tone', 70, 'High Flash Two-Tone', 5},
{'1983 Toyota Corolla Levin 3door GTV (AE86)', 'Manual', 20000, 50000, 15, 3, 'High Metal', 25, 'High Tech', 70, 'High Flash', 5},
{'1983 Toyota Sprinter Trueno 3door GT-APEX (AE86)', 'Manual', 30000, 75000, 25, 3, 'High Metal Two-Tone', 25, 'High Tech Two-Tone', 70, 'High Flash Two-Tone', 5},
{'1983 Toyota Sprinter Trueno 3door GTV (AE86)', 'Manual', 40000, 75000, 15, 3, 'High Metal', 25, 'High Tech', 70, 'High Flash', 5},

{'1994 Toyota MR2 GT (SW20)', 'Manual', 20000, 35000, 6, 7, 'Super White II', 37, 'Blueish Grey Agendum Mica', 16, 'Black', 35, 'Super Red II', 23, 'Super Bright Yellow', 2, 'Dark Green Mica', 4, 'Strong Blue Metallic', 8},
{'1994 Toyota MR2 GT-S (SW20)', 'Manual', 15000, 30000, 8, 7, 'Super White II', 37, 'Blueish Grey Agendum Mica', 16, 'Black', 35, 'Super Red II', 23, 'Super Bright Yellow', 2, 'Dark Green Mica', 4, 'Strong Blue Metallic', 8},
{'1994 Toyota MR2 G-Limited (SW20)', 'Manual', 8000, 30000, 9, 7, 'Super White II', 37, 'Blueish Grey Agendum Mica', 16, 'Black', 35, 'Super Red II', 23, 'Super Bright Yellow', 2, 'Dark Green Mica', 4, 'Strong Blue Metallic', 8},
{'1994 Toyota MR2 G-Limited (SW20)', 'Automatic', 7000, 25000, 6, 7, 'Super White II', 37, 'Blueish Grey Agendum Mica', 16, 'Black', 35, 'Super Red II', 23, 'Super Bright Yellow', 2, 'Dark Green Mica', 4, 'Strong Blue Metallic', 8},
{'1996 Toyota MR2 GT (SW20)', 'Manual', 20000, 35000, 5, 7, 'Super White II', 28, 'Sonic Shadow Toning', 3, 'Black', 28, 'Super Red II', 35, 'Super Bright Yellow', 3, 'Dark Green Mica', 3, 'Purplish Blue Mica Metallic', 1},
{'1996 Toyota MR2 GT-S (SW20)', 'Manual', 15000, 30000, 7, 7, 'Super White II', 28, 'Sonic Shadow Toning', 3, 'Black', 28, 'Super Red II', 35, 'Super Bright Yellow', 3, 'Dark Green Mica', 3, 'Purplish Blue Mica Metallic', 1},
{'1996 Toyota MR2 G-Limited (SW20)', 'Manual', 8000, 30000, 7, 7, 'Super White II', 28, 'Sonic Shadow Toning', 3, 'Black', 28, 'Super Red II', 35, 'Super Bright Yellow', 3, 'Dark Green Mica', 3, 'Purplish Blue Mica Metallic', 1},
{'1996 Toyota MR2 G-Limited (SW20)', 'Automatic', 7000, 25000, 4, 7, 'Super White II', 28, 'Sonic Shadow Toning', 3, 'Black', 28, 'Super Red II', 35, 'Super Bright Yellow', 3, 'Dark Green Mica', 3, 'Purplish Blue Mica Metallic', 1},
{'1998 Toyota MR2 GT (SW20)', 'Manual', 25000, 40000, 3, 7, 'Super Red II', 36, 'Orange Mica Metallic', 1, 'Beige Mica Metallic', 2, 'Black', 29, 'Dark Purple Mica', 1, 'Super White II', 29, 'Sonic Shadow Toning', 3},
{'1998 Toyota MR2 GT-S (SW20)', 'Manual', 20000, 35000, 5, 7, 'Super Red II', 36, 'Orange Mica Metallic', 1, 'Beige Mica Metallic', 2, 'Black', 29, 'Dark Purple Mica', 1, 'Super White II', 29, 'Sonic Shadow Toning', 3},
{'1998 Toyota MR2 G-Limited (SW20)', 'Manual', 10000, 35000, 5, 7, 'Super Red II', 36, 'Orange Mica Metallic', 1, 'Beige Mica Metallic', 2, 'Black', 29, 'Dark Purple Mica', 1, 'Super White II', 29, 'Sonic Shadow Toning', 3},
{'1998 Toyota MR2 G-Limited (SW20)', 'Automatic', 10000, 35000, 3, 7, 'Super Red II', 36, 'Orange Mica Metallic', 1, 'Beige Mica Metallic', 2, 'Black', 29, 'Dark Purple Mica', 1, 'Super White II', 29, 'Sonic Shadow Toning', 3},

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
local carTimerSelectorRandom = math.randomseed(sim.timeSeconds)
local carSkinRaritySelector = 0

local carTimeSelector = 0 --math.randomseed(sim.timeSeconds)
local carArrayTimer = os.clock()
local carPriceSelector = math.randomseed(sim.timeSeconds)

local carArrayCalculated = false
local pressedNext = false

local uiState = ac.getUI()

function DrawTextCentered(text)
    uiState = ac.getUI()
    
    ui.transparentWindow('raceText', vec2(1920 / 2 - 250, 1080 / 2 - 250), vec2(500,100), function ()
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

local tableCount = -1

local checkListingsTimer = true
local checkListingsClock = os.clock()

function Testing()
    


    ac.debug('invamount', carCollectionAmount)
    ac.debug('inventory', carCollection)

    ac.debug('inv specs', carCollectionState)

    if pressedNext then
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

    local carArrayBuilder = {}

    if carTimeSelector ~= nil and carArray[carTimeSelector] ~= nil then
        ac.debug('CAR NAME', carArray[carTimeSelector] [1])
        carArrayBuilder[0] = carArray[carTimeSelector] [1]
        ac.debug('CAR TRANSMISSION', carArray[carTimeSelector] [2])
        carArrayBuilder[1] = carArray[carTimeSelector] [2]
        ac.debug('CAR PAINT', carArray[carTimeSelector] [(carSkinRaritySelector * 2) + 5])
        carArrayBuilder[2] = carArray[carTimeSelector] [(carSkinRaritySelector * 2) + 5]
        ac.debug('CAR PRICE', carPriceSelector)
        carArrayBuilder[3] = tostring(carPriceSelector)

        
        --usedMarketExpires[table.count(usedMarketExpires)] = carPriceSelector
        
        
        --ac.debug('car array maker', carRarityTempArray)
        --ac.debug('car skin array maker', carSkinRarityTempArray)
    end

    if tableCount < 51 and carArrayTimer + 0.1 < os.clock() and pressedNext == false then
        pressedNext = true
        carTimerSelectorRandom = math.random(30,604800)
        usedMarket[tableCount] = carArrayBuilder
        usedMarketExpires[tableCount] = carTimerSelectorRandom + tonumber(sim.systemTime)
        tableCount = tableCount + 1
    end

    if pressedNext == false then
        for i, pos in ipairs(usedMarketExpires) do
            carRarityTempArray = {}
            carSkinRarityTempArray = {}
            if tonumber(usedMarketExpires[i]) < tonumber(sim.systemTime) and carArrayTimer + 0.2 < os.clock() and confirmCarPurchase == false and checkListingsTimer and pressedNext == false then
                local carArrayBuildertemp = {}
                
                

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

                if carTimeSelector ~= nil and carArray[carTimeSelector] ~= nil then
                    ac.debug('CAR NAME', carArray[carTimeSelector] [1])
                    carArrayBuilder[0] = carArray[carTimeSelector] [1]
                    ac.debug('CAR TRANSMISSION', carArray[carTimeSelector] [2])
                    carArrayBuilder[1] = carArray[carTimeSelector] [2]
                    ac.debug('CAR PAINT', carArray[carTimeSelector] [(carSkinRaritySelector * 2) + 5])
                    carArrayBuilder[2] = carArray[carTimeSelector] [(carSkinRaritySelector * 2) + 5]
                    ac.debug('CAR PRICE', carPriceSelector)
                    carArrayBuilder[3] = tostring(carPriceSelector)
            
                    
                    --usedMarketExpires[table.count(usedMarketExpires)] = carPriceSelector
                    
                    
                    --ac.debug('car array maker', carRarityTempArray)
                    --ac.debug('car skin array maker', carSkinRarityTempArray)
                end

                
                carTimerSelectorRandom = math.random(30,604800)
                usedMarket[i] = carArrayBuilder
                usedMarketExpires[i] = tostring(carTimerSelectorRandom + tonumber(sim.systemTime))
            end

        end
    end

    if not checkListingsTimer and checkListingsClock + 0.01 < os.clock() then
        checkListingsTimer = true
    end

    ac.debug('tablecount', tableCount)
    ac.debug('car time selector', carTimeSelector)

end

function LoadCarMarket()


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

    if loadCheckTimer + 4 > os.clock() then

        CarStatsAmount = storedValues.carStatsAmount
        CarStats = StorageUnpackCarStatsNested(storedValues.carStats, storedValues.carStatsAmount)

        MusicVolume = storedValues.MusicVolume
        died = storedValues.died
        tempEnabled = storedValues.tempEnabled
        tableCount = storedValues.tableCount
        carCollectionAmount = storedValues.carCollectionAmount

        if CarStatsAmount == 0 then
            CarStats[1] = {
                ac.getCarID(0), -- car ID
                10, -- fuel
                0,  -- carDamage0
                0,  -- carDamage1
                0,  -- carDamage2
                0,  -- carDamage3
                1000,  -- engine damage
                80, -- oil amount
                80 -- oil quality
            }
            CarStatsFoundMatch = true
            CarStatsAmount = 1
        else
            for i=1, storedValues.carStatsAmount do
                if tostring(CarStats[i][1]) == tostring(ac.getCarID(0)) then
                    CarStatsSelected = i
                    CarStatsFoundMatch = true
                end
            end

        end
        if storedValues.usedMarket ~= nil then
            usedMarket = StorageUnpackUsedMarketNested(storedValues.usedMarket, 50)
        end
        if storedValues.usedMarketExpires ~= nil then
            usedMarketExpires = StorageUnpack(storedValues.usedMarketExpires, 50, false)
        end
        if storedValues.carModifications ~= "" then
            carModificationsAmount = StorageUnpackCarModificationsAmountNested(storedValues.carModificationsAmount, carCollectionAmount)
            carModifications = StorageUnpackCarModificationsNested(storedValues.carModifications, carCollectionAmount, carModificationsAmount)
        end
        carCollection = StorageUnpackCarCollectionNested(storedValues.carCollection, storedValues.carCollectionAmount)
    end

    if loadCheckTimer + 3.8 < os.clock() then

        if CarStatsFoundMatch == false then

            CarStatsSelected = CarStatsAmount + 1
            CarStatsAmount = CarStatsAmount + 1

            CarStats[CarStatsSelected] = {
                ac.getCarID(0), -- car ID
                10, -- fuel
                0,  -- carDamage0
                0,  -- carDamage1
                0,  -- carDamage2
                0,  -- carDamage3
                1000,  -- engine damage
                80, -- oil amount
                80 -- oil quality
            }
            
            CarStatsFoundMatch = true
            
        end

        loadCheck = true

        physics.setCarFuel(0, CarStats[CarStatsSelected][2])
    elseif loadCheckTimer + 2 > os.clock() and loadCheckTimer + 3.8 < os.clock() then
        
        physics.setCarBodyDamage(0, vec4(CarStats[CarStatsSelected][3], CarStats[CarStatsSelected][4], CarStats[CarStatsSelected][5], CarStats[CarStatsSelected][6]))
        physics.setCarEngineLife(0, CarStats[CarStatsSelected][7])
        engineDamage = CarStats[CarStatsSelected][7]
        physics.blockTeleportingToPits()
        
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

local justwon = false

function script.update(dt)

    ac.storageSetPath('acs_x86', nil)

    DeathSound0:setSource('http://docs.google.com/uc?export=open&id=1XoeTUqU6TDgo0zk7Xo3ai-oliXvXwhlk'):setAutoPlay(false)
    DeathSound1:setSource('http://docs.google.com/uc?export=open&id=1hArZQuTvT1FqEEovr31eNnJm1Swk4_Ce'):setAutoPlay(false)
    DeathSound2:setSource('http://docs.google.com/uc?export=open&id=1nB3-hoj4q7vvVxyM4Sse2M4kZmNWL-8X'):setAutoPlay(false)

    Menu0:setSource('http://docs.google.com/uc?export=open&id=1PH9x-cIfdWAVAwhNu5UZ3ot_qjpuc5SM'):setAutoPlay(false):setVolume(MusicVolume * 0.01)
    Menu1:setSource('http://docs.google.com/uc?export=open&id=1jmxdfUgmyaqPwPa8r5kRSvyodK-WXsi5'):setAutoPlay(false):setVolume(MusicVolume * 0.01)
    Menu2:setSource('http://docs.google.com/uc?export=open&id=1k30QEjvpcCHUwfwYAmWBk53q-U1NyMer'):setAutoPlay(false):setVolume(MusicVolume * 0.01)
    Menu3:setSource('http://docs.google.com/uc?export=open&id=1fmkhiTqETSKN1HwZUQ-aSJhy16IXw3g9'):setAutoPlay(false):setVolume(MusicVolume * 0.01)
    Menu4:setSource('http://docs.google.com/uc?export=open&id=1LIwvs6XHvIUgkU8BZ0Kfk5F_82BZI_BC'):setAutoPlay(false):setVolume(MusicVolume * 0.01)
    Menugtauto:setSource('http://docs.google.com/uc?export=open&id=1-B7imrBnQkEkMo6SFJSESCZ88_jviiUl'):setAutoPlay(false):setVolume(MusicVolume * 0.01)

    ac.debug('car stats array', CarStats)
    ac.debug('car stats amount', CarStatsAmount)
    ac.debug('car stats selector', CarStatsSelected)
    ac.debug('stored car stats array', storedValues.carStats)
    ac.debug('bool match', CarStatsFoundMatch)


	if loadCheck then

        ac.debug('car array id', tostring(CarStats[1][1]))
        ac.debug('car id', tostring(ac.getCarID(0)))

        if saveTimer + 1 < os.clock() then
            saveTimer = os.clock()

            storedValues.MusicVolume = MusicVolume
            storedValues.died = died
            storedValues.tempEnabled = tempEnabled
            if tableCount > 49 then
                storedValues.usedMarket = StoragePackUsedMarketNested(usedMarket)
                storedValues.usedMarketExpires = StoragePack(usedMarketExpires)
            end
            storedValues.carCollectionAmount = carCollectionAmount
            if carCollectionAmount > 0 then
                storedValues.carCollection = StoragePackCarCollectionNested(carCollection, carCollectionAmount)
                storedValues.carModifications = StoragePackCarModificationsNested(carModifications, carCollectionAmount)
                storedValues.carModificationsAmount = StoragePackCarModificationsAmountNested(carModifications, carCollectionAmount)
            else
                storedValues.carCollection = ""
                storedValues.carModifications = ""
                storedValues.carModificationsAmount = ""
            end
            storedValues.tableCount = tableCount

            if loadCheckTimer + 4 < os.clock() then

                storedValues.carStatsAmount = CarStatsAmount
                storedValues.carStats = StoragePackCarStatsNested(CarStats, CarStatsAmount)

                CarStats[CarStatsSelected][2] = fuel
                CarStats[CarStatsSelected][8] = oilAmount
                CarStats[CarStatsSelected][9] = oilQuality
                CarStats[CarStatsSelected][3] = car.damage[0]
                CarStats[CarStatsSelected][4] = car.damage[1]
                CarStats[CarStatsSelected][5] = car.damage[2]
                CarStats[CarStatsSelected][6] = car.damage[3]

                if enginedamageFirstLoad + 10 > os.clock() then
                    CarStats[CarStatsSelected][7] = engineDamage
                    physics.setCarEngineLife(0, engineDamage)
                else
                    CarStats[CarStatsSelected][7] = car.engineLifeLeft
                end

            end

        end

        if loadCheckTimer + 6 < os.clock() then
            Fuel()
        end
        TollManagement()
        SaveCarPosition()

        

        Testing()
        ac.debug('Car Market', usedMarket)
        ac.debug('Car Market Expiration', usedMarketExpires)
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

    ac.debug('car mod amount', carModificationsAmount)
    ac.debug('car mod', carModifications)

    --Servers()

    if cylinders == 0 then
        os.showMessage("MISSING COOLING DATA IN \"engine.ini\"")
        ac.reconnectTo()
    end

    if carFile:get("SAFETY","SAFETY_RATING",0) == 0 then
        os.showMessage("MISSING SAFETY DATA IN \"car.ini\"")
        ac.reconnectTo()
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
            counter = counter - (carhardfactor[1] * 0.15)
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


        local chatMessageEvent = ac.OnlineEvent({
            -- message structure layout:
            message = ac.StructItem.string(50),
            mood = ac.StructItem.float(),
          }, function (sender, data)
            -- got a message from other client (or ourselves; in such case `sender.index` would be 0):
            ac.debug('Got message: from', sender and sender.index or -1)
            ac.debug('Got message: text', data.message)
            ac.debug('Got message: mood', data.mood)
          end)

-- sending a new message:

--if ac.getDriverName(0) == '_935_ Sam S.' then
--chatMessageEvent{ message = 'hello world', mood = 5 }
--end

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

        if deathDetectorTimer + 0.1 < os.clock() then
            deathDetectorTimer = os.clock()
            deathDetectorSpeed = car.speedKmh
        end

        if math.abs(car1.acceleration.x) + math.abs(car1.acceleration.y) + math.abs(car1.acceleration.z) > 20 * safetyRating and deathDetectorSpeed > 50 + (safetyRating * 20) + (hasRollcage * 100) then
            DeathPlayerChance = math.random(0,2)
            ac.sendChatMessage(' has died from crash impact.')
            diedTime = os.clock()
            died = 1
        end

        if gforces < math.abs(car1.acceleration.x) + math.abs(car1.acceleration.y) + math.abs(car1.acceleration.z) then
            gforces = math.abs(car1.acceleration.x) + math.abs(car1.acceleration.y) + math.abs(car1.acceleration.z)
        end

        ac.debug('car acceleration high score', gforces)
        ac.debug('car acceleration', math.abs(car1.acceleration.x) + math.abs(car1.acceleration.y) + math.abs(car1.acceleration.z))
    else
        ac.debug('not working', 'nil')
        
    end


    if ac.load('win') == 1 and justwon == false then
        money = money + 100
        justwon = true
    elseif ac.load('win') == 0 then
        justwon = false
    end

end

function Servers()

    local car0 = ac.getCarState(0)
    local car1 = ac.getCarState(1)
    local car2 = ac.getCarState(2)

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
local finedTime = os.clock()
local setTimer = 0
local showTollFine = 0

function TollManagement()

    if fined then

        showTollFine = 1

        if setTimer == 0 then
            finedTime = os.clock()
            setTimer = 1
        end

        if car.speedKmh > 40 then
            physics.setGentleStop(0, true)
        else
            physics.setGentleStop(0, false)
        end
        
        if finedTime + 30 < os.clock() then
            paid = false
            needspaid = false
            setTimer = 0
            fined = false
            showTollFine = 0
        end
    else
        physics.setGentleStop(0, false)
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
        fueltimewait = math.random(1, 30)
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

    if mapAdvance == false then

        if storedValues.map0 == ac.getTrackID() and storedValues.calledTow == 0 and storedValues.carOrientationMap0X ~= 0 then
            carPosition.x = storedValues.carPositionMap0X
            carPosition.y = storedValues.carPositionMap0Y
            carPosition.z = storedValues.carPositionMap0Z
            carOrientation.x = storedValues.carOrientationMap0X
            carOrientation.y = storedValues.carOrientationMap0Y
            carOrientation.z = storedValues.carOrientationMap0Z
            physics.setCarPosition(0, carPosition, carOrientation)
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
        timewait = math.random(1, 30)
        randomseedmake = true
    end

    if car.speedKmh < 1 and repair == false and car.position:closerToThan(vec3(-2946.11, -131.83, -40.4), 15) or car.speedKmh < 1 and repair == false and car.position:closerToThan(vec3(-3360.04, -138.6, -1194.99), 15) and ac.getServerPortHTTP() == 8282 then
        showMessageRepair0 = true
        if ac.isKeyDown(32) then
            repair = true
        end
    end

    if car.speedKmh < 1 and repair == false and car.position:closerToThan(vec3(-4511.65, 34.78, -6020.22), 5) or car.speedKmh < 1 and repair == false and car.position:closerToThan(vec3(-3360.04, -138.6, -1194.99), 5) and trackType == 1 then
        showMessageRepair0 = true
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

    if calledMechanic == true then
        physics.setCarPosition(0, vec3(-4511.65, 34.78, -6020.22), ac.getCameraDirection())
        calledMechanic = false
    end

    if teleportToPits and justteleported == false then
        ac.tryToTeleportToPits()
        ac.tryToOpenRaceMenu('setup')
        justteleported = true
        teleporttimer = os.clock()
        teleportToPits = false
    end

    if sim.isPaused then
        physics.blockTeleportingToPits()
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
        timewait = math.random(1, 30)
        fueltimewait = math.random(1, 30)
        randomTimeAmountClock = os.clock()
    end

end

local uiColor = rgbm(100, 100, 100, 100)

--function script.draw3D()

--end

MainMenu = 1
MainMenuToggle = 0
StickColor = rgbm(0.3,0.3,0.3,1)
StickColorGroove = rgbm(0.25,0.25,0.25,1)
Sticktoggle = false
Sticktoggleadd = 0
Sticktoggled = false
Oilcaptoggled = false
OilSnapped = false
OilPouring = false
OilDraining = false

MenuState = 0
MenuMusicsSelector = math.randomseed(sim.timeSeconds)
TransferPersonType = 0
Justtransfered = false
UsedMarketScroll = 0
ConfirmCarPurchaseIndex = 1
GarageCarCycle = 0
DisplayGarageCars = true
DisplayGarageCarsTimer = os.clock()
SellCarCheck = false
CarmodsPage = 0

MenuBodyStage = 0
MenuBrakeStage = 0
MenuBrakeFrontStage = 0
MenuBrakeRearStage = 0
MenuEngineStage = 0
MenuEngineCoolStage = 0
MenuEngineIntakeStage = 0
MenuEngineFuelStage = 0
MenuEngineOverhaulStage = 0
MenuDrivetrainStage = 0
MenuDrivetrainGearStage = 0
MenuDrivetrainDiffStage = 0
MenuDrivetrainClutchStage = 0
MenuTurboStage = 0
MenuTurboTurboStage = 0
MenuSuspStage = 0
MenuSuspSwayStage = 0
MenuSuspSpringStage = 0
MenuSuspCoilStage = 0
MenuSuspArmStage = 0
MenuSuspOtherStage = 0

CarArrayX = {}
CarArrayZ = {}

function script.drawUI()

    uiState = ac.getUI()

    local simstate = ac.getSim()
    local playerCarStates

    if MainMenu > 1 then
        MainMenu = 0
    end

    if ac.isKeyDown(121) and not MainMenuToggle then
        MainMenu = MainMenu + 1
        MenuMusicsSelector = math.random(0,4)
        MainMenuToggle = true
    end

    if MainMenuToggle and not ac.isKeyDown(121) then
        MainMenuToggle = false
    end

    if MainMenu == 1 then
        Menu0:pause():setCurrentTime(0)
        Menu1:pause():setCurrentTime(0)
        Menu2:pause():setCurrentTime(0)
        Menu3:pause():setCurrentTime(0)
        Menu4:pause():setCurrentTime(0)
        Menugtauto:pause():setCurrentTime(0)
    end

    if MainMenu == 0 and MenuState == 13 then
        Menugtauto:play()
    else
        Menugtauto:pause():setCurrentTime(0)
    end

    if MainMenu == 0 then

        if car.speedKmh < 5 then
            --physics.setCarNoInput(true)
        end

        if MenuMusicsSelector == 0 and MenuState ~= 13 then
            Menu0:play()
        elseif MenuMusicsSelector == 1 and MenuState ~= 13 then
            Menu1:play()
        elseif MenuMusicsSelector == 2 and MenuState ~= 13 then
            Menu2:play()
        elseif MenuMusicsSelector == 3 and MenuState ~= 13 then
            Menu3:play()
        elseif MenuMusicsSelector == 4 and MenuState ~= 13 then
            Menu4:play()
        else
            Menu0:pause():setCurrentTime(0)
            Menu1:pause():setCurrentTime(0)
            Menu2:pause():setCurrentTime(0)
            Menu3:pause():setCurrentTime(0)
            Menu4:pause():setCurrentTime(0)
        end

        

        if MenuState == 0 then
        
            ui.transparentWindow('Main Menu', vec2(((uiState.windowSize.x - 1920) / 2), ((uiState.windowSize.y - 1080) / 2)), vec2(((uiState.windowSize.x - 1920) / 2) + 1920,((uiState.windowSize.y - 1080) / 2) + 1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('MainMenu', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

                    ui.drawRectFilled(vec2(0,0), vec2(1920,1080), rgbm(0.1,0.1,0.1,0.4))

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))


                    --- MAIN MENU ---

                    ui.setCursorX(1080 / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 270 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('MAIN MENU', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 270 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('MAIN MENU', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 270)
                    ui.setCursorY(29)
                    ui.textColored('MAIN MENU', rgbm(0.8,0,1,1))

                    --- MONEY ---

                    ui.setCursorX(1080 + 300)
                    ui.setCursorY(-186)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(450,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 2)
                    ui.setCursorY(-101 + 2)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 1)
                    ui.setCursorY(-101 + 1)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330)
                    ui.setCursorY(-101)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 2)
                    ui.setCursorY(-95 + 2)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 1)
                    ui.setCursorY(-95 + 1)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370)
                    ui.setCursorY(-95)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))



                    if mortal then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 3)
                        ui.setCursorY(-55 + 2)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 1.5)
                        ui.setCursorY(-55 + 1)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36)
                        ui.setCursorY(-55)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(1,0,0,1))


                    end


                    --- SRP MAP ---

                    ui.setCursorX(1080 / 2 + 100)
                    ui.setCursorY(180)

                    ui.image('https://i.postimg.cc/KYjNJhzp/map-mini.png',vec2(554,819))

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(730)
                    ui.setCursorY(280)
                    ui.textColored('FUEL/REPAIR', rgbm(1,0.5,0,1))

                    ui.drawCircle(vec2(842,315), 5, rgbm(1,0.5,0,1), 30, 10)


                    --- OTHER PLAYERS ---
                    

                    for i = 22, simstate.carsCount do
                        playerCarStates = ac.getCarState(i)
                        if playerCarStates ~= nil and playerCarStates.isConnected then
                            CarArrayX[i] = playerCarStates.position.x
                            CarArrayZ[i] = playerCarStates.position.z
                            if CarArrayX[i] ~= 0 then
                                ui.drawCircle(vec2((1920 / 2) +  CarArrayX[i] / 33 + 22, (1080 / 2) +  CarArrayZ[i] / 33 -50), 5, rgbm(0.6,0,1,1), 30, 15)
                            end
                        end
                
                    end

                    --- YOU ARE HERE ---

                    ui.drawCircle(vec2((1920 / 2) + car.position.x / 33 + 22, (1080 / 2) + car.position.z / 33 -50), 5, rgbm(1,0,0,1), 30, 15)
                    
                    ui.setCursorX((1920 / 2) + car.position.x / 33 + 22 + 20)
                    ui.setCursorY((1080 / 2) + car.position.z / 33 -50 - 35)
                    ui.pushFont(ui.Font.Title)

                    ui.textColored('YOU ARE HERE', rgbm(1,0,0,1))



                    ---
                    

                    ui.setCursorX(0)
                    ui.setCursorY(100)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(95 + 2)
                    ui.setCursorY(215 + 2)
                    ui.textColored('FINANCES', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(95 + 1)
                    ui.setCursorY(215 + 1)
                    ui.textColored('FINANCES', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(95)
                    ui.setCursorY(215)
                    ui.textColored('FINANCES', rgbm(0.8,0,1,1))

                    ui.setCursorX(30)
                    ui.setCursorY(185)

                    if ui.invisibleButton('money', vec2(340,130)) then
                        MenuState = 4
                    end


                    ui.setCursorX(0)
                    ui.setCursorY(300)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(106 + 2)
                    ui.setCursorY(415 + 2)
                    ui.textColored('GARAGE', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(106 + 1)
                    ui.setCursorY(415 + 1)
                    ui.textColored('GARAGE', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(106)
                    ui.setCursorY(415)
                    ui.textColored('GARAGE', rgbm(0.8,0,1,1))

                    ui.setCursorX(30)
                    ui.setCursorY(385)

                    if ui.invisibleButton('garage', vec2(340,130)) then
                        MenuState = 3
                    end

                    ui.setCursorX(0)
                    ui.setCursorY(500)
                

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(100 + 2)
                    ui.setCursorY(615 + 2)
                    ui.textColored('SERVICES', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(100 + 1)
                    ui.setCursorY(615 + 1)
                    ui.textColored('SERVICES', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(100)
                    ui.setCursorY(615)
                    ui.textColored('SERVICES', rgbm(0.8,0,1,1))

                    ui.setCursorX(30)
                    ui.setCursorY(586)

                    if ui.invisibleButton('services', vec2(340,130)) then
                        MenuState = 2
                    end


                    ui.setCursorX(0)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(100 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('SETTINGS', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(100 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('SETTINGS', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(100)
                    ui.setCursorY(815)
                    ui.textColored('SETTINGS', rgbm(0.8,0,1,1))

                    ui.setCursorX(30)
                    ui.setCursorY(786)

                    if ui.invisibleButton('settings', vec2(340,130)) then
                        MenuState = 1
                    end

                    ui.setCursorX(1920 - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(1920 - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('menuquit', vec2(340,130)) then
                        MainMenu = MainMenu + 1
                    end


                end)


            end)
        
        elseif MenuState == 1 then

            ui.transparentWindow('Settings', vec2(((uiState.windowSize.x - 1920) / 2), ((uiState.windowSize.y - 1080) / 2)), vec2(((uiState.windowSize.x - 1920) / 2) + 1920,((uiState.windowSize.y - 1080) / 2) + 1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('setting', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

                    ui.drawRectFilled(vec2(0,0), vec2(1920,1080), rgbm(0.1,0.1,0.1,0.4))

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))

                    if mortal then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 3)
                        ui.setCursorY(-55 + 2)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 1.5)
                        ui.setCursorY(-55 + 1)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36)
                        ui.setCursorY(-55)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(1,0,0,1))


                    end


                    --- SETTINGS ---

                    ui.setCursorX(1080 / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 300 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('SETTINGS', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 300 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('SETTINGS', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 300)
                    ui.setCursorY(29)
                    ui.textColored('SETTINGS', rgbm(0.8,0,1,1))

                    --- MONEY ---

                    ui.setCursorX(1080 + 300)
                    ui.setCursorY(-186)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(450,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 2)
                    ui.setCursorY(-101 + 2)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 1)
                    ui.setCursorY(-101 + 1)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330)
                    ui.setCursorY(-101)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 2)
                    ui.setCursorY(-95 + 2)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 1)
                    ui.setCursorY(-95 + 1)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370)
                    ui.setCursorY(-95)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.setCursorX(0)
                    ui.setCursorY(100)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(61 + 2)
                    ui.setCursorY(215 + 2)
                    ui.textColored('TEMP GAUGE', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(61 + 1)
                    ui.setCursorY(215 + 1)
                    ui.textColored('TEMP GAUGE', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(61)
                    ui.setCursorY(215)
                    ui.textColored('TEMP GAUGE', rgbm(0.8,0,1,1))


                    ui.setCursorX(45)
                    ui.setCursorY(210)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(300,300))

                    if tempEnabled == 1 then

                        ui.pushFont(ui.Font.Title)
                        ui.setCursorX(157 + 1)
                        ui.setCursorY(348 + 1)
                        ui.textColored('ENABLED', rgbm(0.1,0.8,1,0.7))

                        ui.pushFont(ui.Font.Title)
                        ui.setCursorX(157 + 0.5)
                        ui.setCursorY(348 + 0.5)
                        ui.textColored('ENABLED', rgbm(0.8,0,1,1))

                        ui.pushFont(ui.Font.Title)
                        ui.setCursorX(157)
                        ui.setCursorY(348)
                        ui.textColored('ENABLED', rgbm(0.8,0,1,1))

                    else

                        ui.pushFont(ui.Font.Title)
                        ui.setCursorX(157 + 1)
                        ui.setCursorY(348 + 1)
                        ui.textColored('DISABLED', rgbm(0.1,0.8,1,0.7))

                        ui.pushFont(ui.Font.Title)
                        ui.setCursorX(157 + 0.5)
                        ui.setCursorY(348 + 0.5)
                        ui.textColored('DISABLED', rgbm(0.8,0,1,1))

                        ui.pushFont(ui.Font.Title)
                        ui.setCursorX(157)
                        ui.setCursorY(348)
                        ui.textColored('DISABLED', rgbm(0.8,0,1,1))

                    end

                    ui.setCursorX(30)
                    ui.setCursorY(185)

                    if ui.invisibleButton('disabled', vec2(340,210)) then
                        tempEnabled = tempEnabled + 1
                    end

                    if tempEnabled > 1 then
                        tempEnabled = 0
                    end


                    ui.setCursorX(400)
                    ui.setCursorY(140)

                    ui.image('https://i.postimg.cc/T2LsTgTN/UI-PANELS-PURPLE.png',vec2(500,300))

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(485)
                    ui.setCursorY(215)
                    ui.textColored('Enables UI temperature gauge on screen.', rgbm(0.8,0,1,1))

                    ui.setCursorX(0)
                    ui.setCursorY(400)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(76 + 2)
                    ui.setCursorY(515 + 2)
                    ui.textColored('MUSIC VOL.', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(76 + 1)
                    ui.setCursorY(515 + 1)
                    ui.textColored('MUSIC VOL.', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(76)
                    ui.setCursorY(515)
                    ui.textColored('MUSIC VOL.', rgbm(0.8,0,1,1))


                    ui.setCursorX(45)
                    ui.setCursorY(510)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(300,300))

                    ui.setCursorX(195)
                    ui.setCursorY(630)

                    if ui.button('    ', vec2(120,65)) and MusicVolume < 100 then
                        MusicVolume = MusicVolume + 5
                    end

                    ui.setCursorX(75)
                    ui.setCursorY(630)

                    if ui.button('     ', vec2(120,65)) and MusicVolume > 0 then
                        MusicVolume = MusicVolume - 5
                    end

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(93 + 1)
                    ui.setCursorY(625 + 1)
                    ui.textColored('<   ' .. MusicVolume .. '   >', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(93 + 0.5)
                    ui.setCursorY(625 + 0.5)
                    ui.textColored('<   ' .. MusicVolume .. '   >', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(93)
                    ui.setCursorY(625)
                    ui.textColored('<   ' .. MusicVolume .. '   >', rgbm(0.8,0,1,1))

                    ui.setCursorX(400)
                    ui.setCursorY(440)

                    ui.image('https://i.postimg.cc/T2LsTgTN/UI-PANELS-PURPLE.png',vec2(500,300))

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(485)
                    ui.setCursorY(515)
                    ui.textColored('Adjusts the main menu music.', rgbm(0.8,0,1,1))

                    --- BACK ---

                    ui.setCursorX(1920 - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(1920 - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        MenuState = 0
                    end


                end)


            end)

        elseif MenuState == 2 then

            ui.transparentWindow('Services', vec2(((uiState.windowSize.x - 1920) / 2), ((uiState.windowSize.y - 1080) / 2)), vec2(((uiState.windowSize.x - 1920) / 2) + 1920,((uiState.windowSize.y - 1080) / 2) + 1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('service', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

                    ui.drawRectFilled(vec2(0,0), vec2(1920,1080), rgbm(0.1,0.1,0.1,0.4))

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))

                    if mortal then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 3)
                        ui.setCursorY(-55 + 2)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 1.5)
                        ui.setCursorY(-55 + 1)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36)
                        ui.setCursorY(-55)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(1,0,0,1))


                    end


                    --- SERVICES ---

                    ui.setCursorX(1080 / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 302 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('SERVICES', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 302 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('SERVICES', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 302)
                    ui.setCursorY(29)
                    ui.textColored('SERVICES', rgbm(0.8,0,1,1))

                    --- MONEY ---

                    ui.setCursorX(1080 + 300)
                    ui.setCursorY(-186)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(450,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 2)
                    ui.setCursorY(-101 + 2)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 1)
                    ui.setCursorY(-101 + 1)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330)
                    ui.setCursorY(-101)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 2)
                    ui.setCursorY(-95 + 2)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 1)
                    ui.setCursorY(-95 + 1)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370)
                    ui.setCursorY(-95)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.setCursorX(0)
                    ui.setCursorY(100)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(52 + 2)
                    ui.setCursorY(215 + 2)
                    ui.textColored('TUNING SHOP', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(52 + 1)
                    ui.setCursorY(215 + 1)
                    ui.textColored('TUNING SHOP', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(52)
                    ui.setCursorY(215)
                    ui.textColored('TUNING SHOP', rgbm(0.8,0,1,1))

                    ui.setCursorX(30)
                    ui.setCursorY(185)

                    if ui.invisibleButton('tuningShop', vec2(340,210)) then
                        MenuState = 20
                    end

                    ui.setCursorX(400)
                    ui.setCursorY(140)

                    ui.image('https://i.postimg.cc/T2LsTgTN/UI-PANELS-PURPLE.png',vec2(500,300))

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(465)
                    ui.setCursorY(215)
                    ui.textColored('Brings you to the tuning shop menu where', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(465)
                    ui.setCursorY(240)
                    ui.textColored('you can buy aftermarket parts.', rgbm(0.8,0,1,1))

                    -- DEALERSHIP --

                    ui.setCursorX(0)
                    ui.setCursorY(350)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(75 + 2)
                    ui.setCursorY(465 + 2)
                    ui.textColored('DEALERSHIP', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(75 + 1)
                    ui.setCursorY(465 + 1)
                    ui.textColored('DEALERSHIP', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(75)
                    ui.setCursorY(465)
                    ui.textColored('DEALERSHIP', rgbm(0.8,0,1,1))

                    ui.setCursorX(30)
                    ui.setCursorY(435)

                    if ui.invisibleButton('dealershipservice', vec2(340,210)) then
                        MenuState = 12
                    end

                    ui.setCursorX(400)
                    ui.setCursorY(390)

                    ui.image('https://i.postimg.cc/T2LsTgTN/UI-PANELS-PURPLE.png',vec2(500,300))

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(465)
                    ui.setCursorY(465)
                    ui.textColored('Brings you to the car dealership menu where', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(465)
                    ui.setCursorY(490)
                    ui.textColored('you can buy cars.', rgbm(0.8,0,1,1))

                    -- TOW --

                    ui.setCursorX(1000)
                    ui.setCursorY(100)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1142 + 2)
                    ui.setCursorY(215 + 2)
                    ui.textColored('TOW', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1142 + 1)
                    ui.setCursorY(215 + 1)
                    ui.textColored('TOW', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1142)
                    ui.setCursorY(215)
                    ui.textColored('TOW', rgbm(0.8,0,1,1))

                    ui.setCursorX(1030)
                    ui.setCursorY(185)

                    if ui.invisibleButton('towservice', vec2(340,210)) then
                        calledMechanic = true
                    end

                    ui.setCursorX(1400)
                    ui.setCursorY(140)

                    ui.image('https://i.postimg.cc/T2LsTgTN/UI-PANELS-PURPLE.png',vec2(500,300))

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(1465)
                    ui.setCursorY(215)
                    ui.textColored('Teleports you to the repair shop in case car is', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(1465)
                    ui.setCursorY(240)
                    ui.textColored('damaged. Use this if you get stuck as well.', rgbm(0.8,0,1,1))


                    ui.setCursorX(1000)
                    ui.setCursorY(350)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1145 + 2)
                    ui.setCursorY(465 + 2)
                    ui.textColored('FUEL', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1145 + 1)
                    ui.setCursorY(465 + 1)
                    ui.textColored('FUEL', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1145)
                    ui.setCursorY(465)
                    ui.textColored('FUEL', rgbm(0.8,0,1,1))

                    ui.setCursorX(1030)
                    ui.setCursorY(435)

                    if ui.invisibleButton('fuelservice', vec2(340,210)) then
                        physics.setCarPosition(0, vec3(-4515.52, 34.75, -6014.95), ac.getCameraDirection())
                    end

                    ui.setCursorX(1400)
                    ui.setCursorY(390)

                    ui.image('https://i.postimg.cc/T2LsTgTN/UI-PANELS-PURPLE.png',vec2(500,300))

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(1465)
                    ui.setCursorY(465)
                    ui.textColored('Teleports you to the fuel station in case car is', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(1465)
                    ui.setCursorY(490)
                    ui.textColored('out of fuel.', rgbm(0.8,0,1,1))


                    --- BACK ---

                    ui.setCursorX(1920 - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(1920 - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        MenuState = 0
                    end


                end)


            end)

        elseif MenuState == 3 then

            ui.transparentWindow('ENGINES', vec2(((uiState.windowSize.x - 1920) / 2), ((uiState.windowSize.y - 1080) / 2)), vec2(((uiState.windowSize.x - 1920) / 2) + 1920,((uiState.windowSize.y - 1080) / 2) + 1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('Engine', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

                    ui.drawRectFilled(vec2(0,0), vec2(1920,1080), rgbm(0.1,0.1,0.1,0.4))

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))

                    if mortal then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 3)
                        ui.setCursorY(-55 + 2)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 1.5)
                        ui.setCursorY(-55 + 1)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36)
                        ui.setCursorY(-55)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(1,0,0,1))


                    end


                    --- GARAGE ---

                    ui.setCursorX(1080 / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 312 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('GARAGE', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 312 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('GARAGE', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 312)
                    ui.setCursorY(29)
                    ui.textColored('GARAGE', rgbm(0.8,0,1,1))

                    --- MONEY ---

                    ui.setCursorX(1080 + 300)
                    ui.setCursorY(-186)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(450,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 2)
                    ui.setCursorY(-101 + 2)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 1)
                    ui.setCursorY(-101 + 1)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330)
                    ui.setCursorY(-101)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 2)
                    ui.setCursorY(-95 + 2)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 1)
                    ui.setCursorY(-95 + 1)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370)
                    ui.setCursorY(-95)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))


                    --- CARS ---

                    ui.setCursorX(0)
                    ui.setCursorY(100)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(135 + 2)
                    ui.setCursorY(215 + 2)
                    ui.textColored('CARS', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(135 + 1)
                    ui.setCursorY(215 + 1)
                    ui.textColored('CARS', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(135)
                    ui.setCursorY(215)
                    ui.textColored('CARS', rgbm(0.8,0,1,1))

                    ui.setCursorX(30)
                    ui.setCursorY(185)

                    if ui.invisibleButton('cars', vec2(340,130)) then
                        MenuState = 15
                    end

                    --- ENGINE ---

                    ui.setCursorX(0)
                    ui.setCursorY(300)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(115 + 2)
                    ui.setCursorY(415 + 2)
                    ui.textColored('ENGINE', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(115 + 1)
                    ui.setCursorY(415 + 1)
                    ui.textColored('ENGINE', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(115)
                    ui.setCursorY(415)
                    ui.textColored('ENGINE', rgbm(0.8,0,1,1))

                    ui.setCursorX(30)
                    ui.setCursorY(385)

                    if ui.invisibleButton('engine', vec2(340,130)) then
                        MenuState = 13
                    end




                    --- BACK ---

                    ui.setCursorX(1920 - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(1920 - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        MenuState = 0
                    end


                end)


            end)


        elseif MenuState == 4 then

            ui.transparentWindow('MONEYS', vec2(((uiState.windowSize.x - 1920) / 2), ((uiState.windowSize.y - 1080) / 2)), vec2(((uiState.windowSize.x - 1920) / 2) + 1920,((uiState.windowSize.y - 1080) / 2) + 1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('Money', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

                    ui.drawRectFilled(vec2(0,0), vec2(1920,1080), rgbm(0.1,0.1,0.1,0.4))

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))

                    if mortal then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 3)
                        ui.setCursorY(-55 + 2)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 1.5)
                        ui.setCursorY(-55 + 1)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36)
                        ui.setCursorY(-55)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(1,0,0,1))


                    end


                    --- SERVICES ---

                    ui.setCursorX(1080 / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 292 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('FINANCES', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 292 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('FINANCES', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 292)
                    ui.setCursorY(29)
                    ui.textColored('FINANCES', rgbm(0.8,0,1,1))

                    --- MONEY ---

                    ui.setCursorX(1080 + 300)
                    ui.setCursorY(-186)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(450,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 2)
                    ui.setCursorY(-101 + 2)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 1)
                    ui.setCursorY(-101 + 1)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330)
                    ui.setCursorY(-101)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 2)
                    ui.setCursorY(-95 + 2)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 1)
                    ui.setCursorY(-95 + 1)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370)
                    ui.setCursorY(-95)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))



                    ui.setCursorX(0)
                    ui.setCursorY(100)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(59 + 2)
                    ui.setCursorY(215 + 2)
                    ui.textColored('TRANSFER cr.', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(59 + 1)
                    ui.setCursorY(215 + 1)
                    ui.textColored('TRANSFER cr.', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(59)
                    ui.setCursorY(215)
                    ui.textColored('TRANSFER cr.', rgbm(0.8,0,1,1))

                    ui.setCursorX(30)
                    ui.setCursorY(185)

                    if ui.invisibleButton('transfer', vec2(340,130)) then
                        MenuState = 11
                    end


                    --- BACK ---

                    ui.setCursorX(1920 - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(1920 - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        MenuState = 0
                    end


                end)


            end)

        elseif MenuState == 11 then

            ui.transparentWindow('TRANSFER', vec2(((uiState.windowSize.x - 1920) / 2), ((uiState.windowSize.y - 1080) / 2)), vec2(((uiState.windowSize.x - 1920) / 2) + 1920,((uiState.windowSize.y - 1080) / 2) + 1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('Transfers', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

                    ui.drawRectFilled(vec2(0,0), vec2(1920,1080), rgbm(0.1,0.1,0.1,0.4))

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))

                    if mortal then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 3)
                        ui.setCursorY(-55 + 2)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 1.5)
                        ui.setCursorY(-55 + 1)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36)
                        ui.setCursorY(-55)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(1,0,0,1))


                    end


                    --- SERVICES ---

                    ui.setCursorX(1080 / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 292 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('TRANSFER', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 292 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('TRANSFER', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 292)
                    ui.setCursorY(29)
                    ui.textColored('TRANSFER', rgbm(0.8,0,1,1))

                    --- MONEY ---

                    ui.setCursorX(1080 + 300)
                    ui.setCursorY(-186)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(450,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 2)
                    ui.setCursorY(-101 + 2)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 1)
                    ui.setCursorY(-101 + 1)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330)
                    ui.setCursorY(-101)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 2)
                    ui.setCursorY(-95 + 2)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 1)
                    ui.setCursorY(-95 + 1)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370)
                    ui.setCursorY(-95)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))


                    --- MONEY AMOUNT TRANSFER ---

                    ui.setCursorX(1080/2 + 175)
                    ui.setCursorY(-25)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(450,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 152 + 2)
                    ui.setCursorY(58 + 2)
                    ui.dwriteTextAligned(moneyTransfer, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 152 + 1)
                    ui.setCursorY(58 + 1)
                    ui.dwriteTextAligned(moneyTransfer, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 152)
                    ui.setCursorY(58)
                    ui.dwriteTextAligned(moneyTransfer, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 195 + 2)
                    ui.setCursorY(65 + 2)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 195 + 1)
                    ui.setCursorY(65 + 1)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 195)
                    ui.setCursorY(65)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    --- +1 ---

                    ui.setCursorX(1080/2 + 450)
                    ui.setCursorY(245)

                    ui.image('https://i.postimg.cc/6QMPph7g/SQ-BUTTON-BLUE.png',vec2(200,150))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 235 + 2)
                    ui.setCursorY(155 + 2)
                    ui.dwriteTextAligned('1', 30, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 235 + 1)
                    ui.setCursorY(155 + 1)
                    ui.dwriteTextAligned('1', 30, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 235)
                    ui.setCursorY(155)
                    ui.dwriteTextAligned('1', 30, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 220 + 2)
                    ui.setCursorY(205 + 2)
                    ui.dwriteTextAligned('+', 50, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0,1,0,1))

                    ui.setCursorX(1080/2 + 507 + 2)
                    ui.setCursorY(355 + 2)

                    if ui.invisibleButton('+1', vec2(40,40)) and moneyTransfer < money then
                        moneyTransfer = moneyTransfer + 1
                    end

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 260 + 2)
                    ui.setCursorY(205 + 2)
                    ui.dwriteTextAligned('-', 50, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(1,0,0,1))

                    ui.setCursorX(1080/2 + 553 + 2)
                    ui.setCursorY(355 + 2)

                    if ui.invisibleButton('-1', vec2(40,40)) and moneyTransfer > 0 then
                        moneyTransfer = moneyTransfer - 1
                    end


                    --- +10 ---

                    ui.setCursorX(1080/2 + 350)
                    ui.setCursorY(245)

                    ui.image('https://i.postimg.cc/6QMPph7g/SQ-BUTTON-BLUE.png',vec2(200,150))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 140 + 2)
                    ui.setCursorY(155 + 2)
                    ui.dwriteTextAligned('10', 30, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 140 + 1)
                    ui.setCursorY(155 + 1)
                    ui.dwriteTextAligned('10', 30, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 140)
                    ui.setCursorY(155)
                    ui.dwriteTextAligned('10', 30, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 120 + 2)
                    ui.setCursorY(205 + 2)
                    ui.dwriteTextAligned('+', 50, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0,1,0,1))

                    ui.setCursorX(1080/2 + 407 + 2)
                    ui.setCursorY(355 + 2)

                    if ui.invisibleButton('+10', vec2(40,40)) and moneyTransfer < money - 9 then
                        moneyTransfer = moneyTransfer + 10
                    end

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 160 + 2)
                    ui.setCursorY(205 + 2)
                    ui.dwriteTextAligned('-', 50, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(1,0,0,1))

                    ui.setCursorX(1080/2 + 453 + 2)
                    ui.setCursorY(355 + 2)

                    if ui.invisibleButton('-10', vec2(40,40)) and moneyTransfer > 9 then
                        moneyTransfer = moneyTransfer - 10
                    end

                    --- +100 ---

                    ui.setCursorX(1080/2 + 250)
                    ui.setCursorY(245)

                    ui.image('https://i.postimg.cc/6QMPph7g/SQ-BUTTON-BLUE.png',vec2(200,150))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 50 + 2)
                    ui.setCursorY(155 + 2)
                    ui.dwriteTextAligned('100', 30, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 50 + 1)
                    ui.setCursorY(155 + 1)
                    ui.dwriteTextAligned('100', 30, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 50)
                    ui.setCursorY(155)
                    ui.dwriteTextAligned('100', 30, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 20 + 2)
                    ui.setCursorY(205 + 2)
                    ui.dwriteTextAligned('+', 50, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0,1,0,1))
                    
                    ui.setCursorX(1080/2 + 307 + 2)
                    ui.setCursorY(355 + 2)

                    if ui.invisibleButton('+100', vec2(40,40)) and moneyTransfer < money - 99 then
                        moneyTransfer = moneyTransfer + 100
                    end

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 60 + 2)
                    ui.setCursorY(205 + 2)
                    ui.dwriteTextAligned('-', 50, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(1,0,0,1))

                    ui.setCursorX(1080/2 + 353 + 2)
                    ui.setCursorY(355 + 2)

                    if ui.invisibleButton('-100', vec2(40,40)) and moneyTransfer > 99 then
                        moneyTransfer = moneyTransfer - 100
                    end


                    --- +1000 ---

                    ui.setCursorX(1080/2 + 150)
                    ui.setCursorY(245)

                    ui.image('https://i.postimg.cc/6QMPph7g/SQ-BUTTON-BLUE.png',vec2(200,150))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 - 48 + 2)
                    ui.setCursorY(157 + 2)
                    ui.dwriteTextAligned('1000', 25, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 - 48 + 1)
                    ui.setCursorY(157 + 1)
                    ui.dwriteTextAligned('1000', 25, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 - 48)
                    ui.setCursorY(157)
                    ui.dwriteTextAligned('1000', 25, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 - 80 + 2)
                    ui.setCursorY(205 + 2)
                    ui.dwriteTextAligned('+', 50, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0,1,0,1))

                    ui.setCursorX(1080/2 + 207 + 2)
                    ui.setCursorY(355 + 2)

                    if ui.invisibleButton('+1000', vec2(40,40)) and moneyTransfer < money - 999 then
                        moneyTransfer = moneyTransfer + 1000
                    end

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 - 42 + 2)
                    ui.setCursorY(205 + 2)
                    ui.dwriteTextAligned('-', 50, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(1,0,0,1))

                    ui.setCursorX(1080/2 + 253 + 2)
                    ui.setCursorY(355 + 2)

                    if ui.invisibleButton('-1000', vec2(40,40)) and moneyTransfer > 999 then
                        moneyTransfer = moneyTransfer - 1000
                    end


                    --- MONEY TRANSFER PERSON ---

                    ui.setCursorX(1080/2 + 80)
                    ui.setCursorY(225)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(650,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 175)
                    ui.setCursorY(437 + 2)
                    ui.textColored(ac.getDriverName(TransferPersonType), rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 175)
                    ui.setCursorY(437 + 1)
                    ui.textColored(ac.getDriverName(TransferPersonType), rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 175)
                    ui.setCursorY(437)
                    ui.textColored(ac.getDriverName(TransferPersonType), rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 300 + 2)
                    ui.setCursorY(405 + 2)
                    ui.dwriteTextAligned('NEXT', 50, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.5,0.5,0.5,1))

                    ui.setCursorX(1080/2 + 460)
                    ui.setCursorY(525 + 2)

                    --22

                    if TransferPersonType < simstate.connectedCars - 1 then
                        if ui.invisibleButton('next', vec2(200,100)) then
                            TransferPersonType = TransferPersonType + 1
                        end
                    end

                    ui.setCursorX(1080/2 + 150)
                    ui.setCursorY(525 + 2)

                    if TransferPersonType > 0 then
                        if ui.invisibleButton('previous', vec2(250,100)) then
                            TransferPersonType = TransferPersonType - 1
                        end
                    end

                    ui.setCursorX(1080/2 + 300)
                    ui.setCursorY(655 + 2)


                    if ui.button('TRANSFER', vec2(250,100)) then
                        money = money - moneyTransfer
                        TransferMoney()
                    end

        

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 60 + 2)
                    ui.setCursorY(405 + 2)
                    ui.dwriteTextAligned('PREVIOUS', 50, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.5,0.5,0.5,1))


                    --- BACK ---

                    ui.setCursorX(1920 - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(1920 - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        MenuState = 4
                    end


                end)


            end)


        elseif MenuState == 12 then

            ui.transparentWindow('DEALERSHIP', vec2(((uiState.windowSize.x - 1920) / 2), ((uiState.windowSize.y - 1080) / 2)), vec2(((uiState.windowSize.x - 1920) / 2) + 1920,((uiState.windowSize.y - 1080) / 2) + 1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('Dealership', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

                    ui.drawRectFilled(vec2(0,0), vec2(1920,1080), rgbm(0.1,0.1,0.1,0.4))

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))

                    if mortal then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 3)
                        ui.setCursorY(-55 + 2)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 1.5)
                        ui.setCursorY(-55 + 1)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36)
                        ui.setCursorY(-55)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(1,0,0,1))


                    end


                    --- DEALERSHIP ---

                    ui.setCursorX(1080 / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 278 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('DEALERSHIP', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 278 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('DEALERSHIP', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 278)
                    ui.setCursorY(29)
                    ui.textColored('DEALERSHIP', rgbm(0.8,0,1,1))

                    --- MONEY ---

                    ui.setCursorX(1080 + 300)
                    ui.setCursorY(-186)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(450,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 2)
                    ui.setCursorY(-101 + 2)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 1)
                    ui.setCursorY(-101 + 1)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330)
                    ui.setCursorY(-101)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 2)
                    ui.setCursorY(-95 + 2)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 1)
                    ui.setCursorY(-95 + 1)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370)
                    ui.setCursorY(-95)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))



                    ui.drawRectFilled(vec2(50,200), vec2(1400,1000), rgbm(1,1,1,0.4))
                    
                    ui.drawLine(vec2(1540,250), vec2(1760,250), rgbm(0.3,0.3,0.3,0.1), 75)
                    ui.drawLine(vec2(1540,350), vec2(1760,350), rgbm(0.3,0.3,0.3,0.1), 75)

                    ui.setCursorX(1576)
                    ui.setCursorY(230)
                    ui.dwriteTextAligned('SCROLL UP', 30, ui.Alignment.Start, ui.Alignment.Start, 1200, false, rgbm(0.8,0.8,0.8,1))

                    ui.setCursorX(1548)
                    ui.setCursorY(330)
                    ui.dwriteTextAligned('SCROLL DOWN', 30, ui.Alignment.Start, ui.Alignment.Start, 1200, false, rgbm(0.8,0.8,0.8,1))

                    ui.setCursorX(1539)
                    ui.setCursorY(313)

                    if ui.button('     ', vec2(221,75), ui.ButtonFlags.Repeat) and UsedMarketScroll > -6700 then
                        UsedMarketScroll = UsedMarketScroll - 10
                    end

                    ui.setCursorX(1539)
                    ui.setCursorY(213)

                    if ui.button('    ', vec2(221,75), ui.ButtonFlags.Repeat) and UsedMarketScroll < 0 then
                        UsedMarketScroll = UsedMarketScroll + 10
                    end
                    
                    if loadCheckTimer + 3 < os.clock() then
                        
                        for i = 1, 50 do

                        
                            if 80 + (i * 150) + UsedMarketScroll > 180 and 80 + (i * 150) + UsedMarketScroll < 1000 then

                                
                                ui.setCursorX(60)
                                ui.setCursorY(-515 + (i * 150) + UsedMarketScroll)
                                ui.dwriteTextAligned(usedMarket[i] [0], 30, ui.Alignment.Start, ui.Alignment.Center, 1200, false, rgbm(0.5,0.2,0.2,1))
                            end

                            if 200 + (i * 150) + UsedMarketScroll > 180 and 200 + (i * 150) + UsedMarketScroll < 1000 then

                                ui.drawLine(vec2(50,200 + (i * 150) + UsedMarketScroll), vec2(1400,200 + (i * 150) + UsedMarketScroll), rgbm(0.2,0.2,0.2,0.4), 5)
                            
                            end

                            if 115 + (i * 150) + UsedMarketScroll > 180 and 115 + (i * 150) + UsedMarketScroll < 1000 then
                                ui.pushFont(ui.Font.Title)
                                ui.setCursorX(100)
                                ui.setCursorY(115 + (i * 150) + UsedMarketScroll)
                                ui.textColored('Color: ' .. usedMarket[i] [2], rgbm(0.2,0.2,0.2,0.85))
                            end

                            if 150 + (i * 150) + UsedMarketScroll > 180 and 150 + (i * 150) + UsedMarketScroll < 1000 then
                                ui.pushFont(ui.Font.Title)
                                ui.setCursorX(100)
                                ui.setCursorY(150 + (i * 150) + UsedMarketScroll)
                                ui.textColored('Transmission: ' .. usedMarket[i] [1], rgbm(0.2,0.2,0.2,0.85))
                            end

                            if 139 + (i * 150) + UsedMarketScroll > 180 and 139 + (i * 150) + UsedMarketScroll < 1000 then
                                ui.pushFont(ui.Font.Huge)
                                ui.setCursorX(800)
                                ui.setCursorY(-11 + (i * 150) + UsedMarketScroll)
                                ui.dwriteTextAligned(usedMarket[i] [3] .. ' cr', 55, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.1,0.1,1))
                                ui.setCursorX(801)
                                ui.setCursorY(-10 + (i * 150) + UsedMarketScroll)
                                ui.dwriteTextAligned(usedMarket[i] [3] .. ' cr', 55, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.1,0.1,1))
                            end

                            if 130 + (i * 150) + UsedMarketScroll > 180 and 130 + (i * 150) + UsedMarketScroll < 1000  then
                                ui.drawLine(vec2(1153,153 + (i * 150) + UsedMarketScroll), vec2(1383,153 + (i * 150) + UsedMarketScroll), rgbm(0.1,0,0.2,0.2), 65)

                            end

                            if 130 + (i * 150) + UsedMarketScroll > 180 and 130 + (i * 150) + UsedMarketScroll < 1000 then
                                ui.setCursorX(1170)
                                ui.setCursorY(-450 + (i * 150) + UsedMarketScroll)
                                ui.dwriteTextAligned('PURCHASE', 40, ui.Alignment.Start, ui.Alignment.Center, 1200, false, rgbm(0.4,0.1,0.8,1))

                            end

                            if 120 + (i * 150) + UsedMarketScroll > 180 and 120 + (i * 150) + UsedMarketScroll < 1000 then
                                ui.setCursorX(1150)
                                ui.setCursorY(120 + (i * 150) + UsedMarketScroll)

                                if ui.invisibleButton('purchasecar' .. tostring(i), vec2(230,65)) then
                                    confirmCarPurchase = true
                                    ConfirmCarPurchaseIndex = i
                                end
                            
                            end
                                
                        end

                    end

                    ui.drawLine(vec2(1420,150), vec2(1420,1050), rgbm(0.3,0.3,0.3,1), 55)
                    ui.drawLine(vec2(25,150), vec2(25,1050), rgbm(0.3,0.3,0.3,1), 55)
                    ui.drawLine(vec2(25,177), vec2(1420,177), rgbm(0.3,0.3,0.3,1), 55)
                    ui.drawLine(vec2(25,1022), vec2(1420,1022), rgbm(0.3,0.3,0.3,1), 55)

                    if confirmCarPurchase then
                        ui.setCursorX(1460)
                        ui.setCursorY(420)

                        ui.image('https://i.postimg.cc/QtPnpxJq/UI-PANELS-BLUE.png',vec2(400,300))
                        
                        ui.drawLine(vec2(1520,628), vec2(1640,628), rgbm(0.1,0,0.2,0.3), 65)
                        ui.drawLine(vec2(1685,628), vec2(1805,628), rgbm(0.1,0,0.2,0.3), 65)

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(1295)
                        ui.setCursorY(465)
                        ui.dwriteTextAligned('YES', 50, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.4,0.5,1,1))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(1460)
                        ui.setCursorY(465)
                        ui.dwriteTextAligned('NO', 50, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.4,0.5,1,1))

                        ui.setCursorX(1520)
                        ui.setCursorY(595)

                        if ui.invisibleButton('conformCarPurchaseYes', vec2(125,65)) and money - tonumber(usedMarket[ConfirmCarPurchaseIndex] [3]) > 0 then
                            checkListingsTimer = false
                            checkListingsClock = os.clock()
                            money = money - tonumber(usedMarket[ConfirmCarPurchaseIndex] [3])
                            carCollectionState[carCollectionAmount] = {}
                            carCollectionState[carCollectionAmount] [0] = 'empty' -- folderName
                            carCollectionState[carCollectionAmount] [1] = tostring(10) -- fuel
                            carCollectionState[carCollectionAmount] [2] = tostring(0) -- carDamage0
                            carCollectionState[carCollectionAmount] [3] = tostring(0) -- carDamage1
                            carCollectionState[carCollectionAmount] [4] = tostring(0) -- carDamage2
                            carCollectionState[carCollectionAmount] [5] = tostring(0) -- carDamage3
                            carCollectionState[carCollectionAmount] [6] = tostring(1000) -- engineDamage
                            carCollectionState[carCollectionAmount] [7] = tostring(100) -- oilAmount
                            carCollectionState[carCollectionAmount] [8] = tostring(100) -- oilQuality
                            if #carModifications == 0 then
                                carModifications = {{usedMarket[ConfirmCarPurchaseIndex][0], 0}}
                            else
                                carModifications [carCollectionAmount + 1] = {usedMarket[ConfirmCarPurchaseIndex][0], 0}
                            end
                            carCollection[carCollectionAmount] = usedMarket[ConfirmCarPurchaseIndex]
                            carCollectionAmount = carCollectionAmount + 1
                            usedMarketExpires[ConfirmCarPurchaseIndex] = tostring(10)
                            confirmCarPurchase = false
                        end

                        ui.setCursorX(1680)
                        ui.setCursorY(595)

                        if ui.invisibleButton('conformCarPurchaseNo', vec2(125,65)) then
                            confirmCarPurchase = false
                        end
                        
                        ui.pushFont(ui.Font.Title)
                        ui.setCursorX(1520)
                        ui.setCursorY(495)
                        ui.textColored('Do you really want to purchase the', rgbm(0.4,0.5,1,1))

                        ui.pushFont(ui.Font.Title)
                        ui.setCursorX(1520)
                        ui.setCursorY(520)
                        ui.textColored(string.sub(usedMarket[ConfirmCarPurchaseIndex] [0], 0, 31), rgbm(0.4,0.5,1,1))
                        
                        ui.pushFont(ui.Font.Title)
                        ui.setCursorX(1520)
                        ui.setCursorY(545)
                        ui.textColored(string.sub(usedMarket[ConfirmCarPurchaseIndex] [0], 32, 63), rgbm(0.4,0.5,1,1))
                        
                    end
                    

                    --- BACK ---

                    ui.setCursorX(1920 - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(1920 - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        MenuState = 2
                    end


                end)


            end)

        elseif MenuState == 13 then

            ui.transparentWindow('ENGINES', vec2(((uiState.windowSize.x - 1920) / 2), ((uiState.windowSize.y - 1080) / 2)), vec2(((uiState.windowSize.x - 1920) / 2) + 1920,((uiState.windowSize.y - 1080) / 2) + 1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('Engine', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

                    ui.drawRectFilled(vec2(0,0), vec2(1920,1080), rgbm(0.1,0.1,0.1,0.4))

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))

                    if mortal then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 3)
                        ui.setCursorY(-55 + 2)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 1.5)
                        ui.setCursorY(-55 + 1)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36)
                        ui.setCursorY(-55)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(1,0,0,1))


                    end


                    --- ENGINE ---

                    ui.setCursorX(1080 / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 302 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('ENGINE', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 302 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('ENGINE', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 302)
                    ui.setCursorY(29)
                    ui.textColored('ENGINE', rgbm(0.8,0,1,1))

                    --- MONEY ---

                    ui.setCursorX(1080 + 300)
                    ui.setCursorY(-186)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(450,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 2)
                    ui.setCursorY(-101 + 2)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 1)
                    ui.setCursorY(-101 + 1)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330)
                    ui.setCursorY(-101)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 2)
                    ui.setCursorY(-95 + 2)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 1)
                    ui.setCursorY(-95 + 1)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370)
                    ui.setCursorY(-95)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))


                    if not Sticktoggled then

                        --- STARTSTOP ---
                        
                        ui.drawCircle(vec2(100,690), 20, rgbm(0.6,0,0,1), 40, 45)
                        ui.drawCircle(vec2(100,690), 40, rgbm(0.5,0,0,1), 40, 15)
    
                        ui.pushFont(ui.Font.Title)
                        ui.setCursorX(75)
                        ui.setCursorY(665)
                        ui.textColored('START', rgbm(0,0,0,1))
                        ui.pushFont(ui.Font.Title)
                        ui.setCursorX(78)
                        ui.setCursorY(690)
                        ui.textColored('STOP', rgbm(0,0,0,1))
    
                        ui.setCursorX(60)
                        ui.setCursorY(640)
    
                        if ui.invisibleButton('START STOP', vec2(100,100)) then
                            if engineIsOn then
                                engineIsOn = false
                            else
                                engineIsOn = true
                            end
                            
                        end
                        
    
                        --- CHECK OIL ---   
    
                        ui.drawCircle(vec2(100,280), 30, rgbm(0.3,0,0,1), 40, 45)
                        ui.drawCircle(vec2(100,280), 20, rgbm(0.35,0,0,1), 40, 45)
                        ui.drawLine(vec2(50,280), vec2(150,280), rgbm(0.5,0,0,1), 20)
    
                        ui.pushFont(ui.Font.Title)
                        ui.setCursorX(60.7)
                        ui.setCursorY(267)
                        ui.textColored('OIL LEVEL', rgbm(0,0,0,1))
    
                        ui.setCursorX(60.7)
                        ui.setCursorY(267)
    
                        if ui.invisibleButton('CHECK OIL', vec2(150,80)) and not OilSnapped then
                            Sticktoggled = true
                        end
    
                        if Oilcaptoggled then
    
                            ui.drawCircle(vec2(250,280), 10, rgbm(0.02,0.02,0.02,1), 40, 20)
                            ui.drawCircle(vec2(250,280), 22, rgbm(0.07,0.07,0.07,1), 40, 8)
                            ui.drawCircle(vec2(250,280), 27, rgbm(0.1,0.1,0.1,1), 40, 8)
                            ui.drawCircle(vec2(250,280), 32, rgbm(0.13,0.13,0.13,1), 40, 8)
                            ui.drawCircle(vec2(250,280), 37, rgbm(0.17,0.17,0.17,1), 40, 8)
                            ui.drawCircle(vec2(250,280), 42, rgbm(0.2,0.2,0.2,1), 40, 8)
    
                            if oilAmount > 150 then
                                ui.drawCircle(vec2(250,280), 10, rgbm(0.32,0.32,0,(math.abs(150 - math.max(150, oilAmount)))/150 * 5), 40, math.max(20, oilAmount - 130))
                            end
    
                            if OilSnapped then
                                ui.setCursorX(ui.mouseLocalPos().x - 40)
                                ui.setCursorY(ui.mouseLocalPos().y - 60)
                            else
                                ui.setCursorX(800)
                                ui.setCursorY(600)
                            end
    
                            ui.image('https://static.vecteezy.com/system/resources/previews/009/381/185/non_2x/motor-oil-bottle-clipart-design-illustration-free-png.png',vec2(100,140))
    
                            if OilSnapped then
    
                                ui.setCursorX(235)
                                ui.setCursorY(295)
                                ui.invisibleButton('OIL FILL', vec2(80,270))
    
                                if ui.itemHovered() and oilAmount < 170 then
                                    OilPouring = true
                                    ui.setCursorX(ui.mouseLocalPos().x - 150)
                                    ui.setCursorY(ui.mouseLocalPos().y - 50)
                                    ui.drawCircle(vec2(ui.mouseLocalPos().x - 23,ui.mouseLocalPos().y - 75), 5, rgbm(0.32,0.32,0,1), 40, 15)
                                    ui.drawCircle(vec2(ui.mouseLocalPos().x - 23,ui.mouseLocalPos().y - 75), 4, rgbm(0.37,0.37,0,1), 40, 15)
                                    ui.drawCircle(vec2(ui.mouseLocalPos().x - 23,ui.mouseLocalPos().y - 75), 3, rgbm(0.45,0.45,0,1), 40, 15)
                                    oilAmount = oilAmount + 0.02
                                    if oilQuality < 100 then
                                        oilQuality = oilQuality + 0.02
                                    end
                                else
                                    OilPouring = false
                                end
    
                                ui.setCursorX(ui.mouseLocalPos().x - 40)
                                ui.setCursorY(ui.mouseLocalPos().y - 60)
                                if ui.invisibleButton('OIL BOTTLE', vec2(110,340)) and not OilPouring then
                                    OilSnapped = false
                                end
    
                            else
                                ui.setCursorX(795)
                                ui.setCursorY(600)
                                if ui.invisibleButton('OIL BOTTLE', vec2(110,340)) then
                                    OilSnapped = true
                                end
                            end
    
    
                        else
    
                            ui.drawCircle(vec2(250,280), 30, rgbm(0.02,0.02,0.02,1), 40, 55)
                            ui.drawCircle(vec2(250,280), 49, rgbm(0.6,0.6,0.02,1), 40, 3)
    
                            ui.setCursorX(218)
                            ui.setCursorY(246)
                            ui.textColored('ENGINE', rgbm(0.6,0.6,0.02,1))
    
                            ui.setCursorX(235)
                            ui.setCursorY(288)
                            ui.textColored('OIL', rgbm(0.6,0.6,0.02,1))
    
                            ui.drawLine(vec2(190,280), vec2(310,280), rgbm(0.03,0.03,0.03,1), 20)
    
                        end
                        
                        ui.setCursorX(190)
                        ui.setCursorY(220)
    
                        if ui.invisibleButton('OIL', vec2(120,320)) then
                            if Oilcaptoggled then
                                Oilcaptoggled = false
                            else
                                Oilcaptoggled = true
                            end
                        end

                        ui.drawRectFilled(vec2(335,230), vec2(456,335), rgbm(1,1,1,0.1), 0, 10)
                        
                        
    
                        ui.setCursorX(350)
                        ui.setCursorY(230)
    
                        if ui.invisibleButton('OIL DRAIN', vec2(90,310)) then
                            if OilDraining or oilAmount < 0.1 then
                                OilDraining = false
                            else
                                OilDraining = true
                                
                            end
                        end
    
                        if OilDraining then
                            ui.setCursorX(351)
                            ui.setCursorY(310)
                            ui.textColored('DRAINING...', rgbm(0.0,0.0,0.0,1)) 
                            oilAmount = oilAmount - 0.01
                        else
                            ui.setCursorX(368)
                            ui.setCursorY(310)
                            ui.textColored('DRAIN', rgbm(0.0,0.0,0.0,1))    
                        end
    
                        if oilAmount < 0.1 and OilDraining then
                            OilDraining = false
                            oilAmount = 0
                            oilQuality = 100
                        end
    
                        ui.setCursorX(360)
                        ui.setCursorY(225)
                        ui.image('https://cdn4.iconfinder.com/data/icons/automotive-maintenance/100/automotive-oil-drain-pan2-512.png',vec2(70,90))
    
                        
    
                    
                    end
    
                    if Sticktoggled then
                        
                        ui.drawLine(vec2(100,300), vec2(600,300), StickColor, 40)
                        ui.drawTriangle(vec2(600,300.5), vec2(600,300.5), vec2(680,300.5), StickColor, 40)
                        ui.drawLine(vec2(630,300), vec2(730,300), StickColor, 10)
    
                        -- markers
    
                        ui.pushFont(ui.Font.Title)
                        ui.setCursorX(275)
                        ui.setCursorY(287)
                        ui.textColored('MAX',StickColorGroove)
                        ui.drawLine(vec2(560,280), vec2(560,320), StickColorGroove, 2)
                        ui.drawLine(vec2(320,280), vec2(320,320), StickColorGroove, 2)
    
                        -- detail lines
    
                        ui.drawLine(vec2(320,300), vec2(340,320), StickColorGroove, 2)
                        ui.drawLine(vec2(320,300), vec2(340,280), StickColorGroove, 2)
    
                        ui.drawLine(vec2(320,280), vec2(360,320), StickColorGroove, 2)
                        ui.drawLine(vec2(340,280), vec2(380,320), StickColorGroove, 2)
                        ui.drawLine(vec2(360,280), vec2(400,320), StickColorGroove, 2)
                        ui.drawLine(vec2(380,280), vec2(420,320), StickColorGroove, 2)
                        ui.drawLine(vec2(400,280), vec2(440,320), StickColorGroove, 2)
                        ui.drawLine(vec2(420,280), vec2(460,320), StickColorGroove, 2)
                        ui.drawLine(vec2(440,280), vec2(480,320), StickColorGroove, 2)
                        ui.drawLine(vec2(460,280), vec2(500,320), StickColorGroove, 2)
                        ui.drawLine(vec2(480,280), vec2(520,320), StickColorGroove, 2)
                        ui.drawLine(vec2(500,280), vec2(540,320), StickColorGroove, 2)
                        ui.drawLine(vec2(520,280), vec2(560,320), StickColorGroove, 2)
    
                        ui.drawLine(vec2(320,320), vec2(360,280), StickColorGroove, 2)
                        ui.drawLine(vec2(340,320), vec2(380,280), StickColorGroove, 2)
                        ui.drawLine(vec2(360,320), vec2(400,280), StickColorGroove, 2)
                        ui.drawLine(vec2(380,320), vec2(420,280), StickColorGroove, 2)
                        ui.drawLine(vec2(400,320), vec2(440,280), StickColorGroove, 2)
                        ui.drawLine(vec2(420,320), vec2(460,280), StickColorGroove, 2)
                        ui.drawLine(vec2(440,320), vec2(480,280), StickColorGroove, 2)
                        ui.drawLine(vec2(460,320), vec2(500,280), StickColorGroove, 2)
                        ui.drawLine(vec2(480,320), vec2(520,280), StickColorGroove, 2)
                        ui.drawLine(vec2(500,320), vec2(540,280), StickColorGroove, 2)
                        ui.drawLine(vec2(520,320), vec2(560,280), StickColorGroove, 2)
    
                        ui.drawLine(vec2(540,320), vec2(560,300), StickColorGroove, 2)
                        ui.drawLine(vec2(540,280), vec2(560,300), StickColorGroove, 2)
    
    
    
                        ui.drawLine(vec2((600 - (oilAmount * 2.8)),300), vec2(600,300), oilColor, 35)
                        ui.drawTriangle(vec2(600,300.5), vec2(600,300.5), vec2(680,300.5), oilColor, 35)
                        ui.drawLine(vec2(660,300), vec2(730,300), oilColor, 8)
    
                        ui.setCursorX(90)
                        ui.setCursorY(270)
    
                        if ui.invisibleButton('CHECK OIL', vec2(650,260)) then
                            Sticktoggled = false
                        end
    
                    end




                    --- BACK ---

                    ui.setCursorX(1920 - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(1920 - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        MenuState = 3
                    end


                end)


            end)


        elseif MenuState == 15 then

            ui.transparentWindow('CARS', vec2(((uiState.windowSize.x - 1920) / 2), ((uiState.windowSize.y - 1080) / 2)), vec2(((uiState.windowSize.x - 1920) / 2) + 1920,((uiState.windowSize.y - 1080) / 2) + 1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('Cars', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

                    ui.drawRectFilled(vec2(0,0), vec2(1920,1080), rgbm(0.1,0.1,0.1,0.4))

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))

                    if mortal then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 3)
                        ui.setCursorY(-55 + 2)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 1.5)
                        ui.setCursorY(-55 + 1)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36)
                        ui.setCursorY(-55)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(1,0,0,1))


                    end


                    --- GARAGE ---

                    ui.setCursorX(1080 / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 342 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('CARS', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 342 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('CARS', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 342)
                    ui.setCursorY(29)
                    ui.textColored('CARS', rgbm(0.8,0,1,1))

                    --- MONEY ---

                    ui.setCursorX(1080 + 300)
                    ui.setCursorY(-186)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(450,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 2)
                    ui.setCursorY(-101 + 2)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 1)
                    ui.setCursorY(-101 + 1)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330)
                    ui.setCursorY(-101)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 2)
                    ui.setCursorY(-95 + 2)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 1)
                    ui.setCursorY(-95 + 1)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370)
                    ui.setCursorY(-95)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))



                    ui.drawRectFilled(vec2(240,190), vec2(1610,410), rgbm(0.4,0.3,0.7,0.1))
                    ui.drawRectFilled(vec2(250,200), vec2(1600,400), rgbm(0.15,0.0,0.5,0.4))
        
                    

                    if loadCheckTimer + 3 < os.clock() and carCollectionAmount > 0 then

                        ui.drawLine(vec2(1530,550), vec2(1770,550), rgbm(0.4,0.3,0.7,0.1), 95)
                        ui.drawLine(vec2(1530,650), vec2(1770,650), rgbm(0.4,0.3,0.7,0.1), 95)

                        ui.drawLine(vec2(1540,550), vec2(1760,550), rgbm(0.15,0.0,0.5,0.4), 75)
                        ui.drawLine(vec2(1540,650), vec2(1760,650), rgbm(0.15,0.0,0.5,0.4), 75)

                        ui.drawLine(vec2(770,550), vec2(1130,550), rgbm(0.4,0.3,0.7,0.1), 175)
                        ui.drawLine(vec2(780,550), vec2(1120,550), rgbm(0.15,0.0,0.5,0.4), 155)

                        if DisplayGarageCars then
                            ui.setCursorX(350)
                            ui.setCursorY(230)
                            ui.dwriteTextAligned(carCollection[GarageCarCycle] [0], 30, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(0.9,0.3,1,1))
        
                            ui.setCursorX(336)
                            ui.setCursorY(295)
                            ui.dwriteTextAligned(carCollection[GarageCarCycle] [2], 20, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(0.5,0.8,1,1))
        
                            ui.setCursorX(336)
                            ui.setCursorY(340)
                            ui.dwriteTextAligned(carCollection[GarageCarCycle] [1], 20, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(0.5,0.8,1,1))
        
                            ui.setCursorX(1612)
                            ui.setCursorY(530)
                            ui.dwriteTextAligned('NEXT', 30, ui.Alignment.Start, ui.Alignment.Start, 1200, false, rgbm(0.9,0.3,1,1))
        
                            ui.setCursorX(1583)
                            ui.setCursorY(630)
                            ui.dwriteTextAligned('PREVIOUS', 30, ui.Alignment.Start, ui.Alignment.Start, 1200, false, rgbm(0.9,0.3,1,1))
        
                            ui.setCursorX(350)
                            ui.setCursorY(490)
                            ui.dwriteTextAligned('SELL', 50, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(1,0,0,1))
        
                            ui.setCursorX(350)
                            ui.setCursorY(560)
                            ui.dwriteTextAligned('(' .. math.round(carCollection[GarageCarCycle] [3] / 2, 0) .. ')', 30, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(1,0,0,0.8))
        
                        end

                        ui.setCursorX(1539)
                        ui.setCursorY(513)

                        if ui.button('        ', vec2(221,75), ui.ButtonFlags.Repeat) then
                            CarmodsPage = 0
                            if GarageCarCycle < carCollectionAmount - 1 then
                                GarageCarCycle = GarageCarCycle + 1
                            else
                                GarageCarCycle = 0
                            end
                        end

                        ui.setCursorX(1539)
                        ui.setCursorY(613)

                        if ui.button('       ', vec2(221,75), ui.ButtonFlags.Repeat) then
                            CarmodsPage = 0
                            if GarageCarCycle == 0 then
                                GarageCarCycle = carCollectionAmount - 1
                            else
                                GarageCarCycle = GarageCarCycle - 1
                            end
                        end

                        ui.setCursorX(779)
                        ui.setCursorY(473)

                        if ui.button('         ', vec2(341,155), ui.ButtonFlags.Repeat) then
                            SellCarCheck = true
                        end

                    else
                        ui.setCursorX(350)
                        ui.setCursorY(230)
                        ui.dwriteTextAligned('NONE FOR NOW', 60, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(0.9,0.3,1,1))
        

                    end

                    
                    ui.drawLine(vec2(40,725), vec2(660,725), rgbm(0.4,0.3,0.7,0.1), 525)
                    ui.drawLine(vec2(50,725), vec2(650,725), rgbm(0.15,0.0,0.5,0.4), 505)

                    ui.setCursorX(230)
                    ui.setCursorY(490)
                    ui.dwriteTextAligned('MODIFICATIONS', 30, ui.Alignment.Start, ui.Alignment.Start, 1200, false, rgbm(0.9,0.3,1,1))

                    if loadCheckTimer + 3 < os.clock() and carCollectionAmount > 0 then

                        if (CarmodsPage * 14) + carModifications[GarageCarCycle + 1] [2] - 1 > 14 * (CarmodsPage + 1) then
                            ui.drawLine(vec2(250,1030), vec2(450,1030), rgbm(0.4,0.3,0.7,0.1), 75)
                            ui.drawLine(vec2(260,1030), vec2(440,1030), rgbm(0.4,0.3,0.7,0.1), 65)

                            ui.setCursorX(315)
                            ui.setCursorY(1010)
                            ui.dwriteTextAligned('NEXT', 30, ui.Alignment.Start, ui.Alignment.Start, 1200, false, rgbm(0.9,0.3,1,1))

                            ui.setCursorX(250)
                            ui.setCursorY(992)

                            if ui.button('              ', vec2(200,75), ui.ButtonFlags.Repeat) then
                                if (CarmodsPage + 1) * 14 < carModifications[GarageCarCycle + 1] [2] - 1  then
                                    CarmodsPage = CarmodsPage + 1
                                else
                                    CarmodsPage = 0
                                end
                                
                            end

                        end

                        for i = 0, 14 do
                            if carModifications[GarageCarCycle + 1] [(CarmodsPage * 14 * 2) + i * 2 + 3] ~= nil then
                                ui.setCursorX(70)
                                ui.setCursorY(530 + i * 30)
                                ui.dwriteTextAligned(carModifications[GarageCarCycle + 1] [(CarmodsPage * 14 * 2) + (i * 2 + 3)] .. ' : ' .. carModifications[GarageCarCycle + 1] [(CarmodsPage * 14 * 2) + (i * 2 + 4)], 18, ui.Alignment.Start, ui.Alignment.Start, 1200, false, rgbm(0.5,0.8,1,1))
                            end
                        end
                    end

                    if SellCarCheck then
                        CarmodsPage = 0

                        ui.drawLine(vec2(770,745), vec2(1130,745), rgbm(0.4,0.3,0.7,0.1), 205)

                        ui.drawLine(vec2(780,685), vec2(1120,685), rgbm(0.15,0.0,0.5,0.4), 65)

                        ui.drawLine(vec2(780,785), vec2(920,785), rgbm(0.15,0.0,0.5,0.4), 105)
                        ui.drawLine(vec2(980,785), vec2(1120,785), rgbm(0.15,0.0,0.5,0.4), 105)

                        ui.setCursorX(350)
                        ui.setCursorY(660)
                        ui.dwriteTextAligned('ARE YOU SURE?', 35, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(0.9,0.3,1,1))

                        ui.setCursorX(250)
                        ui.setCursorY(750)
                        ui.dwriteTextAligned('YES', 50, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(0.9,0.3,1,1))
        
                        ui.setCursorX(450)
                        ui.setCursorY(750)
                        ui.dwriteTextAligned('NO', 50, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(0.9,0.3,1,1))
        

                        ui.setCursorX(779)
                        ui.setCursorY(733)

                        if ui.button('          ', vec2(141,105), ui.ButtonFlags.Repeat) then
                            CarmodsPage = 0
                            DisplayGarageCars = false
                            money = money + tonumber(math.round(carCollection[GarageCarCycle] [3] / 2, 0))
                            for i = GarageCarCycle + 1, carCollectionAmount - 1 do
                                carCollection[i - 1] = carCollection[i]
                                carModifications[i] = carModifications[i + 1]
                                carModificationsAmount[i] = carModificationsAmount[i + 1]
                            end
                            if GarageCarCycle > 0 then
                                GarageCarCycle = GarageCarCycle - 1
                            end
                            carCollection[carCollectionAmount - 1] = nil
                            carModifications[carCollectionAmount] = nil
                            carModificationsAmount[carCollectionAmount] = nil
                            carCollectionAmount = carCollectionAmount - 1
                            DisplayGarageCarsTimer = os.clock()
                            SellCarCheck = false
                        end

                        ui.setCursorX(979)
                        ui.setCursorY(733)

                        if ui.button('           ', vec2(141,105), ui.ButtonFlags.Repeat) then
                            SellCarCheck = false
                        end
                    end

                    
                    if not DisplayGarageCars and DisplayGarageCarsTimer + 0.01 < os.clock() then
                        GarageCarCycle = 0
                        DisplayGarageCars = true
                    end


                    --- BACK ---

                    ui.setCursorX(1920 - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(1920 - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        CarmodsPage = 0
                        MenuState = 3
                    end


                end)


            end)

        elseif MenuState == 20 then

            ui.transparentWindow('TUNING SHOP', vec2(((uiState.windowSize.x - 1920) / 2), ((uiState.windowSize.y - 1080) / 2)), vec2(((uiState.windowSize.x - 1920) / 2) + 1920,((uiState.windowSize.y - 1080) / 2) + 1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('TuningShop', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

                    ui.drawRectFilled(vec2(0,0), vec2(1920,1080), rgbm(0.1,0.1,0.1,0.4))

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))

                    if mortal then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 3)
                        ui.setCursorY(-55 + 2)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 1.5)
                        ui.setCursorY(-55 + 1)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36)
                        ui.setCursorY(-55)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(1,0,0,1))


                    end


                    --- DEALERSHIP ---

                    ui.setCursorX(1080 / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('TUNING SHOP', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('TUNING SHOP', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258)
                    ui.setCursorY(29)
                    ui.textColored('TUNING SHOP', rgbm(0.8,0,1,1))

                    --- MONEY ---

                    ui.setCursorX(1080 + 300)
                    ui.setCursorY(-186)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(450,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 2)
                    ui.setCursorY(-101 + 2)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 1)
                    ui.setCursorY(-101 + 1)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330)
                    ui.setCursorY(-101)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 2)
                    ui.setCursorY(-95 + 2)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 1)
                    ui.setCursorY(-95 + 1)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370)
                    ui.setCursorY(-95)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.drawLine(vec2(120,304), vec2(280,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(520,304), vec2(680,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(920,304), vec2(1080,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(1320,304), vec2(1480,304), rgbm(0.1,0.1,0.1,1), 140)

                    ui.drawLine(vec2(120,554), vec2(280,554), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(520,554), vec2(680,554), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(920,554), vec2(1080,554), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(1320,554), vec2(1480,554), rgbm(0.1,0.1,0.1,1), 140)


                    ui.setCursorX(100)
                    ui.setCursorY(200)

                    ui.image('https://i.postimg.cc/kgfkQvGv/ICONS-BODY.png',vec2(200, 200))

                    ui.setCursorX(500)
                    ui.setCursorY(203)

                    ui.image('https://i.postimg.cc/905SmxgC/ICONS-BRAKES.png',vec2(200, 200))

                    ui.setCursorX(903)
                    ui.setCursorY(210)

                    ui.image('https://i.postimg.cc/zBR61mjx/ICONS-ENGINE.png',vec2(200, 200))

                    ui.setCursorX(1336)
                    ui.setCursorY(230)

                    ui.image('https://i.postimg.cc/0NjhcKJR/ICONS-DRIVETRAIN.png',vec2(130, 150))

                    ui.setCursorX(127)
                    ui.setCursorY(482)

                    ui.image('https://i.postimg.cc/VLwT2VbF/ICONS-TURBO.png',vec2(150, 150))

                    ui.setCursorX(541)
                    ui.setCursorY(497)

                    ui.image('https://i.postimg.cc/QCQzHpv5/ICONS-SUSPENSION.png',vec2(120, 120))

                    ui.setCursorX(940)
                    ui.setCursorY(499)

                    ui.image('https://i.postimg.cc/BZHkY0t6/ICONS-TIRES.png',vec2(120, 120))

                    ui.setCursorX(1322)
                    ui.setCursorY(470)

                    ui.image('https://i.postimg.cc/vHWFcGjC/ICONS-OTHER.png',vec2(160, 160))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(40)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Body', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(440)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Brakes', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))
                    
                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(840)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Engine', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1240)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Drivetrain', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(40)
                    ui.setCursorY(497)
                    ui.dwriteTextAligned('Turbo', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(440)
                    ui.setCursorY(497)
                    ui.dwriteTextAligned('Suspension', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))
                    
                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(840)
                    ui.setCursorY(497)
                    ui.dwriteTextAligned('Tyres', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1240)
                    ui.setCursorY(497)
                    ui.dwriteTextAligned('Other', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))


                    ui.drawLine(vec2(120,854), vec2(1380,854), rgbm(0.21,0.21,0.21,1), 190)

                    if carCollectionAmount > 0 then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(125)
                        ui.setCursorY(175)
                        ui.dwriteTextAligned('SELECTED CAR TO PUT PARTS ON', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.8,0.8,0.8,0.9))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(125)
                        ui.setCursorY(220)
                        ui.dwriteTextAligned(carCollection[GarageCarCycle][0], 32, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(1,0.2,0.1,1))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(475)
                        ui.setCursorY(265)
                        ui.dwriteTextAligned(carCollection[GarageCarCycle][2], 23, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.8,0.8,0.8,1))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(475)
                        ui.setCursorY(305)
                        ui.dwriteTextAligned(carCollection[GarageCarCycle][1], 23, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.8,0.8,0.8,1))

                        ui.setCursorX(120)
                        ui.setCursorY(870)

                        if ui.button('PREV.', vec2(180,80)) then
                            if GarageCarCycle == 0 then
                                GarageCarCycle = carCollectionAmount - 1
                            else
                                GarageCarCycle = GarageCarCycle - 1
                            end
                        end

                        ui.setCursorX(1200)
                        ui.setCursorY(870)

                        if ui.button('NEXT', vec2(180,80)) then
                            if GarageCarCycle < carCollectionAmount - 1 then
                                GarageCarCycle = GarageCarCycle + 1
                            else
                                GarageCarCycle = 0
                            end
                        end

                        

                    else
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(125)
                        ui.setCursorY(225)
                        ui.dwriteTextAligned('PURCHASE CAR FIRST BEFORE USING TUNING SHOP', 45, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.8,0.8,0.8,1))
                    end

                    ui.setCursorX(120)
                    ui.setCursorY(235)

                    if ui.button(' ', vec2(160,140)) then
                        MenuState = 21
                    end

                    ui.setCursorX(520)
                    ui.setCursorY(235)

                    if ui.button('  ', vec2(160,140)) then
                        MenuState = 22
                    end

                    ui.setCursorX(920)
                    ui.setCursorY(235)

                    if ui.button('   ', vec2(160,140)) then
                        MenuState = 23
                    end

                    ui.setCursorX(1320)
                    ui.setCursorY(235)

                    if ui.button('    ', vec2(160,140)) then
                        MenuState = 24
                    end

                    ui.setCursorX(120)
                    ui.setCursorY(485)

                    if ui.button('     ', vec2(160,140)) then
                        MenuState = 25
                    end

                    ui.setCursorX(520)
                    ui.setCursorY(485)

                    if ui.button('      ', vec2(160,140)) then
                        MenuState = 26
                    end

                    ui.setCursorX(920)
                    ui.setCursorY(485)

                    if ui.button('       ', vec2(160,140)) then
                        MenuState = 27
                    end

                    ui.setCursorX(1320)
                    ui.setCursorY(485)

                    if ui.button('        ', vec2(160,140)) then
                        MenuState = 28
                    end

                    --- BACK ---

                    ui.setCursorX(1920 - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(1920 - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        MenuState = 2
                    end


                end)


            end)


        elseif MenuState == 21 then

            ui.transparentWindow('BODY TUNING SHOP', vec2(((uiState.windowSize.x - 1920) / 2), ((uiState.windowSize.y - 1080) / 2)), vec2(((uiState.windowSize.x - 1920) / 2) + 1920,((uiState.windowSize.y - 1080) / 2) + 1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('BodyTuningShop', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

                    ui.drawRectFilled(vec2(0,0), vec2(1920,1080), rgbm(0.1,0.1,0.1,0.4))

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))

                    if mortal then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 3)
                        ui.setCursorY(-55 + 2)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 1.5)
                        ui.setCursorY(-55 + 1)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36)
                        ui.setCursorY(-55)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(1,0,0,1))


                    end


                    --- DEALERSHIP ---

                    ui.setCursorX(1080 / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('TUNING SHOP', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('TUNING SHOP', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258)
                    ui.setCursorY(29)
                    ui.textColored('TUNING SHOP', rgbm(0.8,0,1,1))

                    --- MONEY ---

                    ui.setCursorX(1080 + 300)
                    ui.setCursorY(-186)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(450,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 2)
                    ui.setCursorY(-101 + 2)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 1)
                    ui.setCursorY(-101 + 1)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330)
                    ui.setCursorY(-101)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 2)
                    ui.setCursorY(-95 + 2)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 1)
                    ui.setCursorY(-95 + 1)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370)
                    ui.setCursorY(-95)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.drawLine(vec2(120,854), vec2(1380,854), rgbm(0.21,0.21,0.21,1), 190)

                    ui.drawLine(vec2(120,304), vec2(280,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(520,304), vec2(680,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(920,304), vec2(1080,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(1320,304), vec2(1480,304), rgbm(0.1,0.1,0.1,1), 140)

                    ui.setCursorX(125)
                    ui.setCursorY(230)

                    ui.image('https://i.postimg.cc/cJXc6XVt/rollbar.png',vec2(150, 150))

                    ui.setCursorX(531)
                    ui.setCursorY(235)

                    ui.image('https://i.postimg.cc/jS6cYscX/halfcage.png',vec2(140, 140))

                    ui.setCursorX(921)
                    ui.setCursorY(242)

                    ui.image('https://i.postimg.cc/HLp2pfPC/fullcage.png',vec2(160, 130))

                    ui.setCursorX(1321)
                    ui.setCursorY(250)

                    ui.image('https://i.postimg.cc/SxbdPX6R/chassis.png',vec2(160, 120))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(40)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Roll Bar', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(440)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Half Cage', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))
                    
                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(840)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Full Cage', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1240)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Chassis', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))
                    
                    ui.setCursorX(120)
                    ui.setCursorY(235)

                    if ui.button(' ', vec2(160,140)) then
                        MenuBodyStage = 0
                    end

                    ui.setCursorX(520)
                    ui.setCursorY(235)

                    if ui.button('  ', vec2(160,140)) then
                        MenuBodyStage = 1
                    end

                    ui.setCursorX(920)
                    ui.setCursorY(235)

                    if ui.button('   ', vec2(160,140)) then
                        MenuBodyStage = 2
                    end

                    ui.setCursorX(1320)
                    ui.setCursorY(235)

                    if ui.button('    ', vec2(160,140)) then
                        MenuBodyStage = 3
                    end

                    if MenuBodyStage == 0 then
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(125)
                        ui.setCursorY(175)
                        ui.dwriteTextAligned('ROLL BAR', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                   
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(-135)
                        ui.setCursorY(305)
                        ui.dwriteTextAligned('500 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(165)
                        ui.setCursorY(215)
                        ui.dwriteTextAligned('Typically popular in convertibles, a roll bar provides protection for possible roll overs and can help stiffen the chassis somewhat.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    
                    elseif MenuBodyStage == 1 then
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(125)
                        ui.setCursorY(175)
                        ui.dwriteTextAligned('HALF CAGE', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                   
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(-135)
                        ui.setCursorY(305)
                        ui.dwriteTextAligned('500 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(165)
                        ui.setCursorY(215)
                        ui.dwriteTextAligned('A half cage is a partial roll cage that reinforces the driver\'s area of a car to make it somewhat safer, particularly in the event of a rollover.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(135)
                        ui.setCursorY(245)
                        ui.dwriteTextAligned('Half cages can also help stiffen the car chassis somewhat.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    
                    elseif MenuBodyStage == 2 then
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(125)
                        ui.setCursorY(175)
                        ui.dwriteTextAligned('FULL CAGE', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                   
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(-135)
                        ui.setCursorY(305)
                        ui.dwriteTextAligned('1000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(165)
                        ui.setCursorY(215)
                        ui.dwriteTextAligned('A full cage is a roll cage that reinforces the driver\'s area of a car to make it much safer, particularly in the event of a rollover. Full cages', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(135)
                        ui.setCursorY(245)
                        ui.dwriteTextAligned('can also help stiffen the car chassis somewhat.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    
                    elseif MenuBodyStage == 3 then
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(125)
                        ui.setCursorY(175)
                        ui.dwriteTextAligned('STITCH WELD CAR CHASSIS', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                   
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(-135)
                        ui.setCursorY(305)
                        ui.dwriteTextAligned('1500 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(165)
                        ui.setCursorY(215)
                        ui.dwriteTextAligned('Stitch welding the car chassis provide a huge improvement to the torsional rigitity of the chassis, which can be very helpful in making a', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(135)
                        ui.setCursorY(245)
                        ui.dwriteTextAligned('car more stable and predictable at high stress situations for the car body.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    
                    end
                    
                    ui.setCursorX(145)
                    ui.setCursorY(315)
                    ui.dwriteTextAligned('PURCHASE', 40, ui.Alignment.End, ui.Alignment.Center, 1200, false, rgbm(0.6,0.2,1,1))

                    ui.setCursorX(1138)
                    ui.setCursorY(879)
                    if ui.button('       ', vec2(220,70)) then
                        if MenuBodyStage == 0 then
                            money = money - 500
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Roll Bar'
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '500'
                            carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                        elseif MenuBodyStage == 1 then
                            money = money - 500
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Half Cage'
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '500'
                            carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                        elseif MenuBodyStage == 2 then
                            money = money - 1000
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Full Cage'
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '1000'
                            carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                        elseif MenuBodyStage == 3 then
                            money = money - 1500
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Chassis Stengthening'
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '1500'
                            carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                        end
                    end
                    
                    --- BACK ---

                    ui.setCursorX(1920 - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(1920 - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        MenuState = 20
                    end


                end)


            end)

        elseif MenuState == 22 then

            ui.transparentWindow('BRAKE TUNING SHOP', vec2(((uiState.windowSize.x - 1920) / 2), ((uiState.windowSize.y - 1080) / 2)), vec2(((uiState.windowSize.x - 1920) / 2) + 1920,((uiState.windowSize.y - 1080) / 2) + 1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('BrakeTuningShop', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

                    ui.drawRectFilled(vec2(0,0), vec2(1920,1080), rgbm(0.1,0.1,0.1,0.4))

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))

                    if mortal then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 3)
                        ui.setCursorY(-55 + 2)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 1.5)
                        ui.setCursorY(-55 + 1)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36)
                        ui.setCursorY(-55)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(1,0,0,1))


                    end


                    --- DEALERSHIP ---

                    ui.setCursorX(1080 / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('TUNING SHOP', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('TUNING SHOP', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258)
                    ui.setCursorY(29)
                    ui.textColored('TUNING SHOP', rgbm(0.8,0,1,1))

                    --- MONEY ---

                    ui.setCursorX(1080 + 300)
                    ui.setCursorY(-186)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(450,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 2)
                    ui.setCursorY(-101 + 2)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 1)
                    ui.setCursorY(-101 + 1)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330)
                    ui.setCursorY(-101)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 2)
                    ui.setCursorY(-95 + 2)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 1)
                    ui.setCursorY(-95 + 1)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370)
                    ui.setCursorY(-95)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.drawLine(vec2(120,854), vec2(1380,854), rgbm(0.21,0.21,0.21,1), 190)

                    ui.drawLine(vec2(120,304), vec2(280,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(520,304), vec2(680,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(920,304), vec2(1080,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(1320,304), vec2(1480,304), rgbm(0.1,0.1,0.1,1), 140)

                    ui.setCursorX(45)
                    ui.setCursorY(150)

                    ui.image('https://i.postimg.cc/MG5pwSg3/brakepads.png',vec2(310, 310))

                    ui.setCursorX(535)
                    ui.setCursorY(240)

                    ui.image('https://i.postimg.cc/wjKvcFh2/brakedisc.png',vec2(130, 130))

                    ui.setCursorX(931)
                    ui.setCursorY(269)

                    ui.image('https://i.postimg.cc/zGnfdW7r/brakefront.png',vec2(140, 70))

                    ui.setCursorX(1331)
                    ui.setCursorY(268)

                    ui.image('https://i.postimg.cc/pdRL3Tcn/brakerear.png',vec2(140, 70))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(40)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Brake Pads', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(440)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Brake Rotors', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))
                    
                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(840)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Front Calipers', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1240)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Rear Calipers', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))
                    
                    ui.setCursorX(120)
                    ui.setCursorY(235)

                    if ui.button(' ', vec2(160,140)) then
                        MenuBrakeStage = 0
                    end

                    ui.setCursorX(520)
                    ui.setCursorY(235)

                    if ui.button('  ', vec2(160,140)) then
                        MenuBrakeStage = 1
                    end

                    ui.setCursorX(920)
                    ui.setCursorY(235)

                    if ui.button('   ', vec2(160,140)) then
                        MenuBrakeStage = 2
                    end

                    ui.setCursorX(1320)
                    ui.setCursorY(235)

                    if ui.button('    ', vec2(160,140)) then
                        MenuBrakeStage = 3
                    end

                    if MenuBrakeStage == 0 then
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(125)
                        ui.setCursorY(175)
                        ui.dwriteTextAligned('PERFORMANCE BRAKE PADS', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                   
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(-135)
                        ui.setCursorY(305)
                        ui.dwriteTextAligned('150 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(165)
                        ui.setCursorY(215)
                        ui.dwriteTextAligned('Performance brake pads are made to withstand higher temperatures and provide better friction. This will reduce brake fade and shorten', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(135)
                        ui.setCursorY(245)
                        ui.dwriteTextAligned('the stopping distance. Note this kit comes with 4 brake pads.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                    elseif MenuBrakeStage == 1 then
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(125)
                        ui.setCursorY(175)
                        ui.dwriteTextAligned('DRILLED/SLOTTED BRAKE ROTORS', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                   
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(-135)
                        ui.setCursorY(305)
                        ui.dwriteTextAligned('150 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(165)
                        ui.setCursorY(215)
                        ui.dwriteTextAligned('Drilled and slotted rotors improve the heat dissilation and better the cleaning of the brake pad contact area. Note this kit covers drilled,', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(135)
                        ui.setCursorY(245)
                        ui.dwriteTextAligned('slotted, or both drilled and slotted rotors. Comes with 4 rotors in total.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    
                    elseif MenuBrakeStage == 2 then

                        ui.setCursorX(1080)
                        ui.setCursorY(235)

                        if ui.button('                     ', vec2(110,140)) then
                            if MenuBrakeFrontStage > 1 then
                                MenuBrakeFrontStage = 0
                            else
                                MenuBrakeFrontStage = MenuBrakeFrontStage + 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(970)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('next', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        ui.setCursorX(810)
                        ui.setCursorY(235)

                        if ui.button('                                      ', vec2(110,140)) then
                            if MenuBrakeFrontStage == 0 then
                                MenuBrakeFrontStage = 2
                            else
                                MenuBrakeFrontStage = MenuBrakeFrontStage - 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(705)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('prev.', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        if MenuBrakeFrontStage == 0 then
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('4 PISTON PERFORMANCE FRONT BRAKE CALIPER KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('1000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))
                        elseif MenuBrakeFrontStage == 1 then
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('6 PISTON PERFORMANCE FRONT BRAKE CALIPER KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('2000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))
                        elseif MenuBrakeFrontStage == 2 then
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('8 PISTON PERFORMANCE FRONT BRAKE CALIPER KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('4000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(165)
                        ui.setCursorY(215)
                        ui.dwriteTextAligned('Performance brake caliper kits can give more clamping force and handle more heat dissipation. Usually the more pistons the brake', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(135)
                        ui.setCursorY(245)
                        ui.dwriteTextAligned('caliper has the better the performance is, just know that you don\'t always need the biggest brake calipers. Note this kit comes with 2', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(135)
                        ui.setCursorY(275)
                        ui.dwriteTextAligned('calipers for the front.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    elseif MenuBrakeStage == 3 then

                        ui.setCursorX(1480)
                        ui.setCursorY(235)

                        if ui.button('                                ', vec2(110,140)) then
                            if MenuBrakeRearStage > 1 then
                                MenuBrakeRearStage = 0
                            else
                                MenuBrakeRearStage = MenuBrakeRearStage + 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(1370)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('next', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        ui.setCursorX(1210)
                        ui.setCursorY(235)

                        if ui.button('                                                    ', vec2(110,140)) then
                            if MenuBrakeRearStage == 0 then
                                MenuBrakeRearStage = 2
                            else
                                MenuBrakeRearStage = MenuBrakeRearStage - 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(1105)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('prev.', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))



                        if MenuBrakeRearStage == 0 then
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('2 PISTON PERFORMANCE REAR BRAKE CALIPER KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                       
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('500 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))
                        elseif MenuBrakeRearStage == 1 then
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('4 PISTON PERFORMANCE REAR BRAKE CALIPER KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                       
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('1000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))
                        elseif MenuBrakeRearStage == 2 then
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('6 PISTON PERFORMANCE REAR BRAKE CALIPER KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                       
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('2000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(165)
                        ui.setCursorY(215)
                        ui.dwriteTextAligned('Performance brake caliper kits can give more clamping force and handle more heat dissipation. Usually the more pistons the brake', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(135)
                        ui.setCursorY(245)
                        ui.dwriteTextAligned('caliper has the better the performance is, just know that you don\'t always need the biggest brake calipers. Note this kit comes with 2', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(135)
                        ui.setCursorY(275)
                        ui.dwriteTextAligned('calipers for the rear.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    end
                    
                    ui.setCursorX(145)
                    ui.setCursorY(315)
                    ui.dwriteTextAligned('PURCHASE', 40, ui.Alignment.End, ui.Alignment.Center, 1200, false, rgbm(0.6,0.2,1,1))

                    ui.setCursorX(1138)
                    ui.setCursorY(879)
                    if ui.button('       ', vec2(220,70)) then
                        if MenuBrakeStage == 0 then
                            money = money - 150
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Brake Pads'
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '150'
                            carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                        elseif MenuBrakeStage == 1 then
                            money = money - 150
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Brake Rotors'
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '150'
                            carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                        elseif MenuBrakeStage == 2 then
                            if MenuBrakeFrontStage == 0 then
                                money = money - 1000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = '4 Piston Front Calipers'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '1000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuBrakeFrontStage == 1 then
                                money = money - 2000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = '6 Piston Front Calipers'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '2000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuBrakeFrontStage == 2 then
                                money = money - 4000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = '8 Piston Front Calipers'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '4000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            end
                        elseif MenuBrakeStage == 3 then
                            if MenuBrakeRearStage == 0 then
                                money = money - 500
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = '2 Piston Rear Calipers'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '500'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuBrakeRearStage == 1 then
                                money = money - 1000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = '4 Piston Rear Calipers'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '1000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuBrakeRearStage == 2 then
                                money = money - 2000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = '6 Piston Rear Calipers'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '2000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            end
                        end
                    end
                    
                    --- BACK ---

                    ui.setCursorX(1920 - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(1920 - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        MenuState = 20
                    end


                end)


            end)

        elseif MenuState == 23 then

            ui.transparentWindow('ENGINE TUNING SHOP', vec2(((uiState.windowSize.x - 1920) / 2), ((uiState.windowSize.y - 1080) / 2)), vec2(((uiState.windowSize.x - 1920) / 2) + 1920,((uiState.windowSize.y - 1080) / 2) + 1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('EngineTuningShop', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

                    ui.drawRectFilled(vec2(0,0), vec2(1920,1080), rgbm(0.1,0.1,0.1,0.4))

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))

                    if mortal then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 3)
                        ui.setCursorY(-55 + 2)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 1.5)
                        ui.setCursorY(-55 + 1)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36)
                        ui.setCursorY(-55)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(1,0,0,1))


                    end


                    --- DEALERSHIP ---

                    ui.setCursorX(1080 / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('TUNING SHOP', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('TUNING SHOP', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258)
                    ui.setCursorY(29)
                    ui.textColored('TUNING SHOP', rgbm(0.8,0,1,1))

                    --- MONEY ---

                    ui.setCursorX(1080 + 300)
                    ui.setCursorY(-186)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(450,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 2)
                    ui.setCursorY(-101 + 2)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 1)
                    ui.setCursorY(-101 + 1)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330)
                    ui.setCursorY(-101)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 2)
                    ui.setCursorY(-95 + 2)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 1)
                    ui.setCursorY(-95 + 1)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370)
                    ui.setCursorY(-95)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.drawLine(vec2(120,854), vec2(1380,854), rgbm(0.21,0.21,0.21,1), 190)

                    ui.drawLine(vec2(120,304), vec2(280,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(520,304), vec2(680,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(920,304), vec2(1080,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(1320,304), vec2(1480,304), rgbm(0.1,0.1,0.1,1), 140)

                    ui.drawLine(vec2(120,554), vec2(280,554), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(520,554), vec2(680,554), rgbm(0.1,0.1,0.1,1), 140)

                    ui.setCursorX(125)
                    ui.setCursorY(230)

                    ui.image('https://i.postimg.cc/d19SQqYX/cooling.png',vec2(150, 150))

                    ui.setCursorX(530)
                    ui.setCursorY(230)

                    ui.image('https://i.postimg.cc/HsnPHDPZ/exhaust.png',vec2(140, 140))

                    ui.setCursorX(891)
                    ui.setCursorY(199)

                    ui.image('https://i.postimg.cc/rsFZKvyp/intake.png',vec2(220, 220))

                    ui.setCursorX(1331)
                    ui.setCursorY(236)

                    ui.image('https://i.postimg.cc/6qjjRYTf/ecu.png',vec2(140, 140))

                    ui.setCursorX(35)
                    ui.setCursorY(392)

                    ui.image('https://i.postimg.cc/NGpPWfb2/fuelsystem.png',vec2(350, 350))

                    ui.setCursorX(490)
                    ui.setCursorY(448)

                    ui.image('https://i.postimg.cc/TYsN37zR/engineoverhaul.png',vec2(220, 220))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(40)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Cooling', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(440)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Exhaust', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))
                    
                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(840)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Intake', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1240)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('ECU', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(40)
                    ui.setCursorY(497)
                    ui.dwriteTextAligned('Fuel System', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(440)
                    ui.setCursorY(497)
                    ui.dwriteTextAligned('Engine', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.setCursorX(120)
                    ui.setCursorY(235)

                    if ui.button(' ', vec2(160,140)) then
                        MenuEngineStage = 0
                    end

                    ui.setCursorX(520)
                    ui.setCursorY(235)

                    if ui.button('  ', vec2(160,140)) then
                        MenuEngineStage = 1
                    end

                    ui.setCursorX(920)
                    ui.setCursorY(235)

                    if ui.button('   ', vec2(160,140)) then
                        MenuEngineStage = 2
                    end

                    ui.setCursorX(1320)
                    ui.setCursorY(235)

                    if ui.button('    ', vec2(160,140)) then
                        MenuEngineStage = 3
                    end

                    ui.setCursorX(120)
                    ui.setCursorY(485)

                    if ui.button('     ', vec2(160,140)) then
                        MenuEngineStage = 4
                    end

                    ui.setCursorX(520)
                    ui.setCursorY(485)

                    if ui.button('      ', vec2(160,140)) then
                        MenuEngineStage = 5
                    end

                    if MenuEngineStage == 0 then
                        ui.setCursorX(280)
                        ui.setCursorY(235)

                        if ui.button('                     ', vec2(110,140)) then
                            if MenuEngineCoolStage > 0 then
                                MenuEngineCoolStage = 0
                            else
                                MenuEngineCoolStage = MenuEngineCoolStage + 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(170)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('next', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        ui.setCursorX(10)
                        ui.setCursorY(235)

                        if ui.button('                                      ', vec2(110,140)) then
                            if MenuEngineCoolStage == 0 then
                                MenuEngineCoolStage = 1
                            else
                                MenuEngineCoolStage = MenuEngineCoolStage - 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(-105)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('prev.', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        if MenuEngineCoolStage == 0 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('PERFORMANCE RADIATOR', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('500 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('A performance radiator can provide a car with improved cooling efficiency that can handle increased heat generation from a modified', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                        
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('engine. This will allow the engine to run longer without worrying about overheating.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuEngineCoolStage == 1 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('PERFORMANCE INTERCOOLER', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('1500 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('A performance intercooler can provide cars with a turbo improved cooling efficiency that can handle increased heat generation from the', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                        
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('turbo when modified. This will allow the engine to run longer without worrying about overheating. Note this is only for turbocharged cars.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        end

                    elseif MenuEngineStage == 1 then
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(125)
                        ui.setCursorY(175)
                        ui.dwriteTextAligned('AFTERMARKET EXHAUST', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                   
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(-135)
                        ui.setCursorY(305)
                        ui.dwriteTextAligned('800 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(165)
                        ui.setCursorY(215)
                        ui.dwriteTextAligned('An aftermarket exhaust can provide a car with a slight increase in power and a more aggressive sound compared to the stock exhaust', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(135)
                        ui.setCursorY(245)
                        ui.dwriteTextAligned('system due to the larger diameter of pipes allowing better exhaust gas flow.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    
                    elseif MenuEngineStage == 2 then

                        ui.setCursorX(1080)
                        ui.setCursorY(235)

                        if ui.button('                  ', vec2(110,140)) then
                            if MenuEngineIntakeStage > 0 then
                                MenuEngineIntakeStage = 0
                            else
                                MenuEngineIntakeStage = MenuEngineIntakeStage + 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(970)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('next', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        ui.setCursorX(810)
                        ui.setCursorY(235)

                        if ui.button('                            ', vec2(110,140)) then
                            if MenuEngineIntakeStage == 0 then
                                MenuEngineIntakeStage = 1
                            else
                                MenuEngineIntakeStage = MenuEngineIntakeStage - 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(705)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('prev.', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        if MenuEngineIntakeStage == 0 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('PERFORMANCE COLD AIR INTAKE', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('400 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('A performance cold air intake is designed to find cold air in an otherwise hot under-hood environment, improving engine performance.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuEngineIntakeStage == 1 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('AFTERMARKET INTAKE MANIFOLD', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('500 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('An aftermarket intake manifold is specifically designed to optimize airflow into the engine allowing for improved engine performance.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        end

                    elseif MenuEngineStage == 3 then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(125)
                        ui.setCursorY(175)
                        ui.dwriteTextAligned('ECU TUNE', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(-135)
                        ui.setCursorY(305)
                        ui.dwriteTextAligned('800 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(165)
                        ui.setCursorY(215)
                        ui.dwriteTextAligned('An ECU tune can maximize power and acceleration by adjusting parameters like fuel injection, ignition timing, and air-fuel mixture. This', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                    
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(135)
                        ui.setCursorY(245)
                        ui.dwriteTextAligned('will lead to improved engine performance and better engine response.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                    elseif MenuEngineStage == 4 then

                        ui.setCursorX(280)
                        ui.setCursorY(485)

                        if ui.button('                                                                                 ', vec2(110,140)) then
                            if MenuEngineFuelStage > 1 then
                                MenuEngineFuelStage = 0
                            else
                                MenuEngineFuelStage = MenuEngineFuelStage + 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(170)
                        ui.setCursorY(400)
                        ui.dwriteTextAligned('next', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        ui.setCursorX(10)
                        ui.setCursorY(485)

                        if ui.button('                                              ', vec2(110,140)) then
                            if MenuEngineFuelStage == 0 then
                                MenuEngineFuelStage = 2
                            else
                                MenuEngineFuelStage = MenuEngineFuelStage - 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(-105)
                        ui.setCursorY(400)
                        ui.dwriteTextAligned('prev.', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        if MenuEngineFuelStage == 0 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('STAGE 1 PERFORMANCE FUEL SYSTEM KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('400 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('Supporting fuel system for up to OEM engine power +300 additional hp. A performance fuel system is designed to deliver a high volume', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('of fuel at consistent pressure, allowing for optimal power delivery.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuEngineFuelStage == 1 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('STAGE 2 PERFORMANCE FUEL SYSTEM KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('800 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('Supporting fuel system for up to OEM engine power +600 additional hp. A performance fuel system is designed to deliver a high volume', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('of fuel at consistent pressure, allowing for optimal power delivery.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuEngineFuelStage == 2 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('STAGE 3 PERFORMANCE FUEL SYSTEM KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('1600 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('Supporting fuel system for any engine power. A performance fuel system is designed to deliver a high volume of fuel at consistent', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('pressure, allowing for optimal power delivery.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        end

                    elseif MenuEngineStage == 5 then

                        ui.setCursorX(680)
                        ui.setCursorY(485)

                        if ui.button('                                         ', vec2(110,140)) then
                            if MenuEngineOverhaulStage > 1 then
                                MenuEngineOverhaulStage = 0
                            else
                                MenuEngineOverhaulStage = MenuEngineOverhaulStage + 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(570)
                        ui.setCursorY(400)
                        ui.dwriteTextAligned('next', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        ui.setCursorX(410)
                        ui.setCursorY(485)

                        if ui.button('                                                  ', vec2(110,140)) then
                            if MenuEngineOverhaulStage == 0 then
                                MenuEngineOverhaulStage = 2
                            else
                                MenuEngineOverhaulStage = MenuEngineOverhaulStage - 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(305)
                        ui.setCursorY(400)
                        ui.dwriteTextAligned('prev.', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        if MenuEngineOverhaulStage == 0 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('STAGE 1 ENGINE OVERHAUL KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('3000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('For engine with no more than 500 hp, includes all necessary parts for a built engine. An engine overhaul is when a car\'s engine is', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('completely disassembled, thoroughly cleaned, and rebuilt with replacement parts optimal for maximum performance.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuEngineOverhaulStage == 1 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('STAGE 2 ENGINE OVERHAUL KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('5000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('For engine with no more than 700 hp, includes all necessary parts for a built engine. An engine overhaul is when a car\'s engine is', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('completely disassembled, thoroughly cleaned, and rebuilt with replacement parts optimal for maximum performance.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuEngineOverhaulStage == 2 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('STAGE 3 ENGINE OVERHAUL KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('8000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('For engine with more than 700 hp, includes all necessary parts for a built engine. An engine overhaul is when a car\'s engine is completely', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('disassembled, thoroughly cleaned, and rebuilt with replacement parts optimal for maximum performance.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        end
                    end
                    
                    ui.setCursorX(145)
                    ui.setCursorY(315)
                    ui.dwriteTextAligned('PURCHASE', 40, ui.Alignment.End, ui.Alignment.Center, 1200, false, rgbm(0.6,0.2,1,1))

                    ui.setCursorX(1138)
                    ui.setCursorY(879)
                    if ui.button('       ', vec2(220,70)) then
                        if MenuEngineStage == 0 then
                            if MenuEngineCoolStage == 0 then
                                money = money - 500
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Performance Radiator'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '500'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuEngineCoolStage == 1 then
                                money = money - 1500
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Performance Intercooler'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '1500'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            end
                        elseif MenuEngineStage == 1 then
                            money = money - 800
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Aftermarket Exhaust'
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '800'
                            carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                        elseif MenuEngineStage == 2 then
                            if MenuEngineIntakeStage == 0 then
                                money = money - 400
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Cold Air Intake'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '400'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuEngineIntakeStage == 1 then
                                money = money - 500
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Aftermarket Intake Manifold'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '500'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            end
                        elseif MenuEngineStage == 3 then
                            money = money - 800
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'ECU Tune'
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '800'
                            carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                        elseif MenuEngineStage == 4 then
                            if MenuEngineFuelStage == 0 then
                                money = money - 400
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Stage 1 Fuel System'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '400'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuEngineFuelStage == 1 then
                                money = money - 800
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Stage 2 Fuel System'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '800'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuEngineFuelStage == 2 then
                                money = money - 1600
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Stage 3 Fuel System'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '1600'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            end
                        elseif MenuEngineStage == 5 then
                            if MenuEngineOverhaulStage == 0 then
                                money = money - 3000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Stage 1 Engine Overhaul'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '3000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuEngineOverhaulStage == 1 then
                                money = money - 5000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Stage 2 Engine Overhaul'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '5000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuEngineOverhaulStage == 2 then
                                money = money - 8000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Stage 3 Engine Overhaul'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '8000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            end
                        end
                        
                    end
                    
                    --- BACK ---

                    ui.setCursorX(1920 - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(1920 - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        MenuState = 20
                    end


                end)


            end)

        elseif MenuState == 24 then

            ui.transparentWindow('DRIVETRAIN TUNING SHOP', vec2(((uiState.windowSize.x - 1920) / 2), ((uiState.windowSize.y - 1080) / 2)), vec2(((uiState.windowSize.x - 1920) / 2) + 1920,((uiState.windowSize.y - 1080) / 2) + 1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('DrivetrainTuningShop', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

                    ui.drawRectFilled(vec2(0,0), vec2(1920,1080), rgbm(0.1,0.1,0.1,0.4))

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))

                    if mortal then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 3)
                        ui.setCursorY(-55 + 2)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 1.5)
                        ui.setCursorY(-55 + 1)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36)
                        ui.setCursorY(-55)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(1,0,0,1))


                    end


                    --- DEALERSHIP ---

                    ui.setCursorX(1080 / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('TUNING SHOP', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('TUNING SHOP', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258)
                    ui.setCursorY(29)
                    ui.textColored('TUNING SHOP', rgbm(0.8,0,1,1))

                    --- MONEY ---

                    ui.setCursorX(1080 + 300)
                    ui.setCursorY(-186)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(450,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 2)
                    ui.setCursorY(-101 + 2)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 1)
                    ui.setCursorY(-101 + 1)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330)
                    ui.setCursorY(-101)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 2)
                    ui.setCursorY(-95 + 2)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 1)
                    ui.setCursorY(-95 + 1)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370)
                    ui.setCursorY(-95)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.drawLine(vec2(120,854), vec2(1380,854), rgbm(0.21,0.21,0.21,1), 190)

                    ui.drawLine(vec2(120,304), vec2(280,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(520,304), vec2(680,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(920,304), vec2(1080,304), rgbm(0.1,0.1,0.1,1), 140)

                    ui.setCursorX(140)
                    ui.setCursorY(245)

                    ui.image('https://i.postimg.cc/Z515WM04/gear.png',vec2(120, 120))

                    ui.setCursorX(528)
                    ui.setCursorY(233)

                    ui.image('https://i.postimg.cc/6Qn5nfGR/diff.png',vec2(145, 145))

                    ui.setCursorX(935)
                    ui.setCursorY(239)

                    ui.image('https://i.postimg.cc/W3VpnqMy/clutch.png',vec2(130, 130))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(40)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Transmission', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(440)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Differential', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))
                    
                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(840)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Clutch', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.setCursorX(120)
                    ui.setCursorY(235)

                    if ui.button(' ', vec2(160,140)) then
                        MenuDrivetrainStage = 0
                    end

                    ui.setCursorX(520)
                    ui.setCursorY(235)

                    if ui.button('  ', vec2(160,140)) then
                        MenuDrivetrainStage = 1
                    end

                    ui.setCursorX(920)
                    ui.setCursorY(235)

                    if ui.button('   ', vec2(160,140)) then
                        MenuDrivetrainStage = 2
                    end

                    if MenuDrivetrainStage == 0 then
                        ui.setCursorX(280)
                        ui.setCursorY(235)

                        if ui.button('                     ', vec2(110,140)) then
                            if MenuDrivetrainGearStage > 2 then
                                MenuDrivetrainGearStage = 0
                            else
                                MenuDrivetrainGearStage = MenuDrivetrainGearStage + 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(170)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('next', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        ui.setCursorX(10)
                        ui.setCursorY(235)

                        if ui.button('                                      ', vec2(110,140)) then
                            if MenuDrivetrainGearStage == 0 then
                                MenuDrivetrainGearStage = 3
                            else
                                MenuDrivetrainGearStage = MenuDrivetrainGearStage - 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(-105)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('prev.', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        if MenuDrivetrainGearStage == 0 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('AFTERMARKET FINAL GEAR', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('750 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('An aftermarket final gear will change the final drive ratio which will impact the cars acceleration and top speed.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuDrivetrainGearStage == 1 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('AFTERMARKET GEAR SET', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('1000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('An aftermarket gear set will change the gear ratios in the gearbox which will impact the cars acceleration and top speed.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuDrivetrainGearStage == 2 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('TRANSMISSION SWAP', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('2500 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('A transmission swap lets you put in a completely different gearbox from another car. Must remain same transmission type', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('(ex: manual if already manual, automatic if already automatic).', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuDrivetrainGearStage == 3 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('TRANSMISSION CONVERSION KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('5000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('A transmission conversion kit lets you convert a car from automatic to manual or manual to automatic, kit includes gearbox and', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('everything needed for the swap for the car to function (does not include for example manual gauge cluster if automatic one is different).', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        end

                    elseif MenuDrivetrainStage == 1 then

                        ui.setCursorX(680)
                        ui.setCursorY(235)

                        if ui.button('                         ', vec2(110,140)) then
                            if MenuDrivetrainDiffStage > 2 then
                                MenuDrivetrainDiffStage = 0
                            else
                                MenuDrivetrainDiffStage = MenuDrivetrainDiffStage + 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(570)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('next', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        ui.setCursorX(410)
                        ui.setCursorY(235)

                        if ui.button('                                                 ', vec2(110,140)) then
                            if MenuDrivetrainDiffStage == 0 then
                                MenuDrivetrainDiffStage = 3
                            else
                                MenuDrivetrainDiffStage = MenuDrivetrainDiffStage - 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(305)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('prev.', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))


                        if MenuDrivetrainDiffStage == 0 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('OEM REPLACEMENT DIFFERENTIAL', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('500 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('Replaces a current differential with an OEM replacement one sold by the manufacturer. Note this is only one differential.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuDrivetrainDiffStage == 1 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('PERFORMANCE NON ADJUSTABLE LIMITED SLIP DIFFERENTIAL (LSD)', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('1000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('A limited slip differential (LSD) is a system designed to improve traction by preventing excessive wheelspin of one wheel. A performance', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                        
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('one can increase the amount of traction the car has even over an OEM LSD. Note this is non adjustable and includes only one differential.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuDrivetrainDiffStage == 2 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('PERFORMANCE FULLY ADJUSTABLE LIMITED SLIP DIFFERENTIAL (LSD)', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('2500 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('A limited slip differential (LSD) is a system designed to improve traction by preventing excessive wheelspin of one wheel. A performance', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                        
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('one can increase the amount of traction the car has even over an OEM LSD. Note this is fully adjustable and includes only one differential.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuDrivetrainDiffStage == 3 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('ELECTRONICALLY MANAGED DIFFERENTIAL SWAP', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('5000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('An electronically managed differential is a differential that is managed by a computer system. Common systems like this are Mitsubishi', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                        
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('ACD, Nissan ATESSA, Subaru DCCD just to list a few examples. Note this includes the kit for only one differential and should only be', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(275)
                            ui.dwriteTextAligned('bought in special circumstances if you know what you are doing.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        end

                    elseif MenuDrivetrainStage == 2 then

                        ui.setCursorX(1080)
                        ui.setCursorY(235)

                        if ui.button('                  ', vec2(110,140)) then
                            if MenuDrivetrainClutchStage > 0 then
                                MenuDrivetrainClutchStage = 0
                            else
                                MenuDrivetrainClutchStage = MenuDrivetrainClutchStage + 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(970)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('next', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        ui.setCursorX(810)
                        ui.setCursorY(235)

                        if ui.button('                            ', vec2(110,140)) then
                            if MenuDrivetrainClutchStage == 0 then
                                MenuDrivetrainClutchStage = 1
                            else
                                MenuDrivetrainClutchStage = MenuDrivetrainClutchStage - 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(705)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('prev.', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        if MenuDrivetrainClutchStage == 0 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('OEM+ CLUTCH REPLACEMENT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('500 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('Supporting clutches up to a 20% increase over OEM clutch torque in NM. An OEM+ clutch replacement is intended to be a slight', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('upgrade in clutch performance.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuDrivetrainClutchStage == 1 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('HIGH PERFORMANCE CLUTCH', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('1000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('Supporting clutches of any torque. A high performance clutch features reinforced components to handle extreme torque levels and high', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('temperatures without slipping.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        end

                    end
                    
                    ui.setCursorX(145)
                    ui.setCursorY(315)
                    ui.dwriteTextAligned('PURCHASE', 40, ui.Alignment.End, ui.Alignment.Center, 1200, false, rgbm(0.6,0.2,1,1))

                    ui.setCursorX(1138)
                    ui.setCursorY(879)
                    if ui.button('       ', vec2(220,70)) then
                        if MenuDrivetrainStage == 0 then
                            if MenuDrivetrainGearStage == 0 then
                                money = money - 750
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Aftermarket Final Gear'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '750'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuDrivetrainGearStage == 1 then
                                money = money - 1000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Aftermarket Gear Set'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '1000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuDrivetrainGearStage == 2 then
                                money = money - 2500
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Transmission Swap'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '2500'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuDrivetrainGearStage == 3 then
                                money = money - 5000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Transmission Conversion Kit'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '5000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            end
                        elseif MenuDrivetrainStage == 1 then
                            if MenuDrivetrainDiffStage == 0 then
                                money = money - 500
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'OEM Differential'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '500'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuDrivetrainDiffStage == 1 then
                                money = money - 1000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Non adjustable LSD'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '1000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuDrivetrainDiffStage == 2 then
                                money = money - 2500
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Adjustable LSD'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '2500'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuDrivetrainDiffStage == 3 then
                                money = money - 5000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Electronic Differential'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '5000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            end
                        elseif MenuDrivetrainStage == 2 then
                            if MenuDrivetrainClutchStage == 0 then
                                money = money - 500
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'OEM+ Clutch'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '500'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuDrivetrainClutchStage == 1 then
                                money = money - 1000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'High Performance Clutch'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '1000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            end
                        end
                        
                    end
                    
                    --- BACK ---

                    ui.setCursorX(1920 - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(1920 - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        MenuState = 20
                    end


                end)


            end)

        elseif MenuState == 25 then

            ui.transparentWindow('TURBO TUNING SHOP', vec2(((uiState.windowSize.x - 1920) / 2), ((uiState.windowSize.y - 1080) / 2)), vec2(((uiState.windowSize.x - 1920) / 2) + 1920,((uiState.windowSize.y - 1080) / 2) + 1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('TurboTuningShop', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

                    ui.drawRectFilled(vec2(0,0), vec2(1920,1080), rgbm(0.1,0.1,0.1,0.4))

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))

                    if mortal then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 3)
                        ui.setCursorY(-55 + 2)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 1.5)
                        ui.setCursorY(-55 + 1)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36)
                        ui.setCursorY(-55)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(1,0,0,1))


                    end


                    --- DEALERSHIP ---

                    ui.setCursorX(1080 / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('TUNING SHOP', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('TUNING SHOP', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258)
                    ui.setCursorY(29)
                    ui.textColored('TUNING SHOP', rgbm(0.8,0,1,1))

                    --- MONEY ---

                    ui.setCursorX(1080 + 300)
                    ui.setCursorY(-186)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(450,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 2)
                    ui.setCursorY(-101 + 2)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 1)
                    ui.setCursorY(-101 + 1)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330)
                    ui.setCursorY(-101)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 2)
                    ui.setCursorY(-95 + 2)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 1)
                    ui.setCursorY(-95 + 1)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370)
                    ui.setCursorY(-95)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.drawLine(vec2(120,854), vec2(1380,854), rgbm(0.21,0.21,0.21,1), 190)

                    ui.drawLine(vec2(120,304), vec2(280,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(520,304), vec2(680,304), rgbm(0.1,0.1,0.1,1), 140)

                    ui.setCursorX(135)
                    ui.setCursorY(240)

                    ui.image('https://i.postimg.cc/J0xkbhwd/turbo-Turbo.png',vec2(130, 130))

                    ui.setCursorX(513)
                    ui.setCursorY(219)

                    ui.image('https://i.postimg.cc/4424hcjR/turbo-Supercharger.png',vec2(175, 175))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(40)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Turbo', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(440)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Supercharger', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.setCursorX(120)
                    ui.setCursorY(235)

                    if ui.button(' ', vec2(160,140)) then
                        MenuTurboStage = 0
                    end

                    ui.setCursorX(520)
                    ui.setCursorY(235)

                    if ui.button('  ', vec2(160,140)) then
                        MenuTurboStage = 1
                    end

                    if MenuTurboStage == 0 then
                        ui.setCursorX(280)
                        ui.setCursorY(235)

                        if ui.button('                     ', vec2(110,140)) then
                            if MenuTurboTurboStage > 1 then
                                MenuTurboTurboStage = 0
                            else
                                MenuTurboTurboStage = MenuTurboTurboStage + 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(170)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('next', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        ui.setCursorX(10)
                        ui.setCursorY(235)

                        if ui.button('                                      ', vec2(110,140)) then
                            if MenuTurboTurboStage == 0 then
                                MenuTurboTurboStage = 2
                            else
                                MenuTurboTurboStage = MenuTurboTurboStage - 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(-105)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('prev.', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        if MenuTurboTurboStage == 0 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('STAGE 1 AFTERMARKET TURBO KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('3000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('For engine with no more than 400 hp. An aftermarket turbo kit is designed to increase the power output of the engine which will impact', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('the cars acceleration and top speed.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuTurboTurboStage == 1 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('STAGE 2 AFTERMARKET TURBO KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('5000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('For engine with no more than 600 hp. An aftermarket turbo kit is designed to increase the power output of the engine which will impact', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('the cars acceleration and top speed.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuTurboTurboStage == 2 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('STAGE 3 AFTERMARKET TURBO KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('8000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('For engine with more than 600 hp. An aftermarket turbo kit is designed to increase the power output of the engine which will impact the', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('cars acceleration and top speed.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        end

                    elseif MenuTurboStage == 1 then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(125)
                        ui.setCursorY(175)
                        ui.dwriteTextAligned('AFTERMARKET SUPERCHARGER KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                
                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(-135)
                        ui.setCursorY(305)
                        ui.dwriteTextAligned('4500 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(165)
                        ui.setCursorY(215)
                        ui.dwriteTextAligned('An aftermarket supercharger kit is designed to increase the power output of the engine which will impact the cars acceleration and top', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(135)
                        ui.setCursorY(245)
                        ui.dwriteTextAligned('speed.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                    end
                    
                    ui.setCursorX(145)
                    ui.setCursorY(315)
                    ui.dwriteTextAligned('PURCHASE', 40, ui.Alignment.End, ui.Alignment.Center, 1200, false, rgbm(0.6,0.2,1,1))

                    ui.setCursorX(1138)
                    ui.setCursorY(879)
                    if ui.button('       ', vec2(220,70)) then
                        if MenuTurboStage == 0 then
                            if MenuTurboTurboStage == 0 then
                                money = money - 3000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Stage 1 Turbo Kit'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '3000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuTurboTurboStage == 1 then
                                money = money - 5000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Stage 2 Turbo Kit'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '5000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuTurboTurboStage == 2 then
                                money = money - 8000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Stage 3 Turbo Kit'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '8000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            end
                        elseif MenuTurboStage == 1 then
                            money = money - 4500
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Supercharger Kit'
                            carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '4500'
                            carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                        end
                        
                    end
                    
                    --- BACK ---

                    ui.setCursorX(1920 - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(1920 - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        MenuState = 20
                    end


                end)


            end)


        elseif MenuState == 26 then

            ui.transparentWindow('SUSP TUNING SHOP', vec2(((uiState.windowSize.x - 1920) / 2), ((uiState.windowSize.y - 1080) / 2)), vec2(((uiState.windowSize.x - 1920) / 2) + 1920,((uiState.windowSize.y - 1080) / 2) + 1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('SuspTuningShop', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

                    ui.drawRectFilled(vec2(0,0), vec2(1920,1080), rgbm(0.1,0.1,0.1,0.4))

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))

                    if mortal then

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 3)
                        ui.setCursorY(-55 + 2)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36 - 1.5)
                        ui.setCursorY(-55 + 1)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(0,0,0,0.5))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(36)
                        ui.setCursorY(-55)
                        ui.dwriteTextAligned('MORTAL', 30, ui.Alignment.Center, ui.Alignment.Top, 324, false, rgbm(1,0,0,1))


                    end


                    --- DEALERSHIP ---

                    ui.setCursorX(1080 / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('TUNING SHOP', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('TUNING SHOP', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 / 2 + 258)
                    ui.setCursorY(29)
                    ui.textColored('TUNING SHOP', rgbm(0.8,0,1,1))

                    --- MONEY ---

                    ui.setCursorX(1080 + 300)
                    ui.setCursorY(-186)

                    ui.image('https://i.postimg.cc/vBDNg6fB/HEXAGON-BUTTON-BLUE.png',vec2(450,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 2)
                    ui.setCursorY(-101 + 2)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330 + 1)
                    ui.setCursorY(-101 + 1)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 330)
                    ui.setCursorY(-101)
                    ui.dwriteTextAligned(money, 54, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 2)
                    ui.setCursorY(-95 + 2)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370 + 1)
                    ui.setCursorY(-95 + 1)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080 + 370)
                    ui.setCursorY(-95)
                    ui.dwriteTextAligned('cr', 40, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.8,0,1,1))

                    ui.drawLine(vec2(120,854), vec2(1380,854), rgbm(0.21,0.21,0.21,1), 190)

                    ui.drawLine(vec2(120,304), vec2(280,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(520,304), vec2(680,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(920,304), vec2(1080,304), rgbm(0.1,0.1,0.1,1), 140)
                    ui.drawLine(vec2(1320,304), vec2(1480,304), rgbm(0.1,0.1,0.1,1), 140)

                    ui.drawLine(vec2(120,554), vec2(280,554), rgbm(0.1,0.1,0.1,1), 140)

                    ui.setCursorX(125)
                    ui.setCursorY(254)

                    ui.image('https://i.postimg.cc/SRjvbgPw/swayBar.png',vec2(150, 100))

                    ui.setCursorX(536)
                    ui.setCursorY(239)

                    ui.image('https://i.postimg.cc/MKCrgbmF/spring.png',vec2(130, 130))

                    ui.setCursorX(941)
                    ui.setCursorY(244)

                    ui.image('https://i.postimg.cc/1XTYmph4/coilover.png',vec2(120, 120))

                    ui.setCursorX(1341)
                    ui.setCursorY(244)

                    ui.image('https://i.postimg.cc/sDQNn07W/geometry.png',vec2(120, 120))

                    ui.setCursorX(80)
                    ui.setCursorY(429)

                    ui.image('https://i.postimg.cc/DfYNPKJF/other.png',vec2(240, 250))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(40)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Sway Bars', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(440)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Springs', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))
                    
                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(840)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Coilovers', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1240)
                    ui.setCursorY(245)
                    ui.dwriteTextAligned('Geometry', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(40)
                    ui.setCursorY(497)
                    ui.dwriteTextAligned('Other', 54, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    ui.setCursorX(120)
                    ui.setCursorY(235)

                    if ui.button(' ', vec2(160,140)) then
                        MenuSuspStage = 0
                    end

                    ui.setCursorX(520)
                    ui.setCursorY(235)

                    if ui.button('  ', vec2(160,140)) then
                        MenuSuspStage = 1
                    end

                    ui.setCursorX(920)
                    ui.setCursorY(235)

                    if ui.button('   ', vec2(160,140)) then
                        MenuSuspStage = 2
                    end

                    ui.setCursorX(1320)
                    ui.setCursorY(235)

                    if ui.button('    ', vec2(160,140)) then
                        MenuSuspStage = 3
                    end

                    ui.setCursorX(120)
                    ui.setCursorY(485)

                    if ui.button('     ', vec2(160,140)) then
                        MenuSuspStage = 4
                    end

                    if MenuSuspStage == 0 then
                        ui.setCursorX(280)
                        ui.setCursorY(235)

                        if ui.button('                     ', vec2(110,140)) then
                            if MenuSuspSwayStage > 0 then
                                MenuSuspSwayStage = 0
                            else
                                MenuSuspSwayStage = MenuSuspSwayStage + 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(170)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('next', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        ui.setCursorX(10)
                        ui.setCursorY(235)

                        if ui.button('                                      ', vec2(110,140)) then
                            if MenuSuspSwayStage == 0 then
                                MenuSuspSwayStage = 1
                            else
                                MenuSuspSwayStage = MenuSuspSwayStage - 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(-105)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('prev.', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        if MenuSuspSwayStage == 0 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('OEM REPLACEMENT SWAY BAR', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('150 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('Note this kit only includes a single sway bar for either the front or the rear. Sway bars are used to help restrict the body roll of a car', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                        
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('which can help increase corning potential in the car.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuSuspSwayStage == 1 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('AFTERMARKET SWAY BAR', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('300 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('Note this kit only includes a single sway bar for either the front or the rear. Sway bars are used to help restrict the body roll of a car', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                        
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('which can help increase corning potential in the car.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        end

                    elseif MenuSuspStage == 1 then

                        ui.setCursorX(680)
                        ui.setCursorY(235)

                        if ui.button('                         ', vec2(110,140)) then
                            if MenuSuspSpringStage > 0 then
                                MenuSuspSpringStage = 0
                            else
                                MenuSuspSpringStage = MenuSuspSpringStage + 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(570)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('next', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        ui.setCursorX(410)
                        ui.setCursorY(235)

                        if ui.button('                                                 ', vec2(110,140)) then
                            if MenuSuspSpringStage == 0 then
                                MenuSuspSpringStage = 1
                            else
                                MenuSuspSpringStage = MenuSuspSpringStage - 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(305)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('prev.', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))


                        if MenuSuspSpringStage == 0 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('LOWERING SPRINGS KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('250 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('Note this kit includes all 4 springs for the car. Lowering springs are a budget way to lower a vehicles ride height and will give a stiffer', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                        
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('suspension feeling. However, since this is only changing the spring rate it can typically cause the car to not match the compression and', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(275)
                            ui.dwriteTextAligned('dampening of the strut which will result in a bouncy and hard ride.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))


                        elseif MenuSuspSpringStage == 1 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('CUSTOM SPRINGS KIT FOR COILOVERS', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('500 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('Note this kit includes all 4 springs for the car and only works with coilovers. Custom springs are designed to replace default springs that', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
                        
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('come on the coilovers you purchased which can give you more customizability of how stiff you want the car to be.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        end

                    elseif MenuSuspStage == 2 then

                        ui.setCursorX(1080)
                        ui.setCursorY(235)

                        if ui.button('                  ', vec2(110,140)) then
                            if MenuSuspCoilStage > 2 then
                                MenuSuspCoilStage = 0
                            else
                                MenuSuspCoilStage = MenuSuspCoilStage + 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(970)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('next', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        ui.setCursorX(810)
                        ui.setCursorY(235)

                        if ui.button('                            ', vec2(110,140)) then
                            if MenuSuspCoilStage == 0 then
                                MenuSuspCoilStage = 3
                            else
                                MenuSuspCoilStage = MenuSuspCoilStage - 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(705)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('prev.', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        if MenuSuspCoilStage == 0 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('STAGE 1 AFTERMARKET COILOVERS', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('1000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('For coilovers priced no more than $1500 USD in real life, these typically include brands like Fortune Auto, BC Racing, and Megan Racing.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('Aftermarket coilovers include different springs and dampers that allow for individual adjustment of the ground clearence and damper', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(275)
                            ui.dwriteTextAligned('behavior. This usually makes the car react a lot better to corners and feel overall stiffer.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuSuspCoilStage == 1 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('STAGE 2 AFTERMARKET COILOVERS', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('3000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('For coilovers priced between $1500 and $4000 USD in real life, these typically include brands like Ohlins, KW, and HKS. Aftermarket', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('coilovers include different springs and dampers that allow for individual adjustment of the ground clearence and damper behavior. This', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(275)
                            ui.dwriteTextAligned('usually makes the car react a lot better to corners and feel overall stiffer.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuSuspCoilStage == 2 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('STAGE 3 AFTERMARKET COILOVERS', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('6000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('For coilovers priced over $4000 USD in real life, these typically are the top of the line motorsport type coilovers from different brands.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('Aftermarket coilovers include different springs and dampers that allow for individual adjustment of the ground clearence and damper', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(275)
                            ui.dwriteTextAligned('behavior. This usually makes the car react a lot better to corners and feel overall stiffer.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuSuspCoilStage == 3 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('STAGE 4 AFTERMARKET COILOVERS', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('9000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('For coilovers that are revalved and custom made, these should only be bought if you know what you are doing. Aftermarket coilovers', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('include different springs and dampers that allow for individual adjustment of the ground clearence and damper behavior. This usually', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(275)
                            ui.dwriteTextAligned('makes the car react a lot better to corners and feel overall stiffer.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        end

                    elseif MenuSuspStage == 3 then

                        ui.setCursorX(1480)
                        ui.setCursorY(235)

                        if ui.button('                                ', vec2(110,140)) then
                            if MenuSuspArmStage > 1 then
                                MenuSuspArmStage = 0
                            else
                                MenuSuspArmStage = MenuSuspArmStage + 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(1370)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('next', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        ui.setCursorX(1210)
                        ui.setCursorY(235)

                        if ui.button('                                                    ', vec2(110,140)) then
                            if MenuSuspArmStage == 0 then
                                MenuSuspArmStage = 2
                            else
                                MenuSuspArmStage = MenuSuspArmStage - 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(1105)
                        ui.setCursorY(145)
                        ui.dwriteTextAligned('prev.', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        if MenuSuspArmStage == 0 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('STEERING ANGLE KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                       
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('1000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('A steering angle kit is designed to increase the steering angle of the car by modifying the front suspension geometry for more', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('pronounced drifts', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuSuspArmStage == 1 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('SUSPENSION COMPONENT REPLACEMENT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                       
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('500 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('Only purchase this if you know what you are doing suspension wise. Note this is only for a specific suspension parts mirrored on both', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('sides, like for changing out the front control arms. You need to purchase it twice if you want to do both front and rear upper control arms', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(275)
                            ui.dwriteTextAligned('or only the front upper and lower control arms for example.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
    
                        elseif MenuSuspArmStage == 2 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('CUSTOM SUSPENSION GEOMETRY', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                       
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('20000 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('Only purchase this if you know what you are doing suspension wise. Highly recommended to not do this unless you are very familar with', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('modifying suspension geometry in this game. This is for fully custom geometry on the car, it can literally be anything you want it to be that', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(275)
                            ui.dwriteTextAligned('is theoretically possible in real life.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))
    
                        end


                    elseif MenuSuspStage == 4 then

                        ui.setCursorX(280)
                        ui.setCursorY(485)

                        if ui.button('                                                                                 ', vec2(110,140)) then
                            if MenuSuspOtherStage > 0 then
                                MenuSuspOtherStage = 0
                            else
                                MenuSuspOtherStage = MenuSuspOtherStage + 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(170)
                        ui.setCursorY(400)
                        ui.dwriteTextAligned('next', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        ui.setCursorX(10)
                        ui.setCursorY(485)

                        if ui.button('                                              ', vec2(110,140)) then
                            if MenuSuspOtherStage == 0 then
                                MenuSuspOtherStage = 1
                            else
                                MenuSuspOtherStage = MenuSuspOtherStage - 1
                            end
                            
                        end

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(-105)
                        ui.setCursorY(400)
                        ui.dwriteTextAligned('prev.', 34, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                        if MenuSuspOtherStage == 0 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('PERFORMANCE RUBBER BUSHINGS KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('300 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('Kit includes all the bushings for the whole car. Aftermarket rubber bushings are designed to make the overall car feel stiffer.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        elseif MenuSuspOtherStage == 1 then

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(125)
                            ui.setCursorY(175)
                            ui.dwriteTextAligned('OEM SHOCK REPLACEMENT KIT', 35, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,1))
                    
                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(-135)
                            ui.setCursorY(305)
                            ui.dwriteTextAligned('500 cr', 35, ui.Alignment.End, ui.Alignment.Center, 1224, false, rgbm(0.95,0.2,0.1,1))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(165)
                            ui.setCursorY(215)
                            ui.dwriteTextAligned('Kit includes shocks for the whole car. Shocks/dampers control the movement of the spring and suspension components and can dictate', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                            ui.pushFont(ui.Font.Huge)
                            ui.setCursorX(135)
                            ui.setCursorY(245)
                            ui.dwriteTextAligned('how the car reacts to bumps.', 20, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.95,0.95,0.95,0.8))

                        end

                    end
                    
                    ui.setCursorX(145)
                    ui.setCursorY(315)
                    ui.dwriteTextAligned('PURCHASE', 40, ui.Alignment.End, ui.Alignment.Center, 1200, false, rgbm(0.6,0.2,1,1))

                    ui.setCursorX(1138)
                    ui.setCursorY(879)
                    if ui.button('       ', vec2(220,70)) then
                        if MenuSuspStage == 0 then
                            if MenuSuspSwayStage == 0 then
                                money = money - 150
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'OEM Replacement ARB'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '150'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuSuspSwayStage == 1 then
                                money = money - 300
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Aftermarket ARB'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '300'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            end
                        elseif MenuSuspStage == 1 then
                            if MenuSuspSpringStage == 0 then
                                money = money - 250
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Lowering Springs'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '250'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuSuspSpringStage == 1 then
                                money = money - 500
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Custom Springs for Coilovers'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '500'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            end
                        elseif MenuSuspStage == 2 then
                            if MenuSuspCoilStage == 0 then
                                money = money - 1000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Stage 1 Coilovers'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '1000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuSuspCoilStage == 1 then
                                money = money - 3000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Stage 2 Coilovers'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '3000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuSuspCoilStage == 2 then
                                money = money - 6000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Stage 3 Coilovers'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '6000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuSuspCoilStage == 3 then
                                money = money - 9000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Stage 4 Coilovers'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '9000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            end
                        elseif MenuSuspStage == 3 then
                            if MenuSuspArmStage == 0 then
                                money = money - 1000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Steering Angle Kit'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '1000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuSuspArmStage == 1 then
                                money = money - 500
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Suspension Component Replacement'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '500'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuSuspArmStage == 2 then
                                money = money - 20000
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Custom Suspension Geometry'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '20000'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            end
                        elseif MenuSuspStage == 4 then
                            if MenuSuspOtherStage == 0 then
                                money = money - 300
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'Rubber Bushings Kit'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '300'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            elseif MenuSuspOtherStage == 1 then
                                money = money - 500
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 3] = 'OEM Shock Replacement'
                                carModifications [GarageCarCycle + 1] [(tonumber(carModifications [GarageCarCycle + 1] [2]) * 2) + 4] = '500'
                                carModifications [GarageCarCycle + 1] [2] = tonumber(carModifications [GarageCarCycle + 1] [2]) + 1
                            end
                        end
                        
                    end
                    
                    --- BACK ---

                    ui.setCursorX(1920 - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1920 - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(1920 - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        MenuState = 20
                    end


                end)


            end)


        end
    else
        --physics.setCarNoInput(false)

    end

    

    if MainMenu == 1 and tempEnabled == 1 then

        ui.transparentWindow('TEMPWINDOW', vec2(0, 0), vec2(1920 / 3,1080 / 3 ), function ()

            ui.pushFont(ui.Font.Huge)
            ui.childWindow('temp', vec2(1920 / 3, 1080 / 3), false, ui.WindowFlags.None, function ()


                ui.setCursorX(-9)
                ui.setCursorY(28)

                ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(350,300))

                --- bar ---

                ui.drawLine(vec2(30,180), vec2(300,180), rgbm(0,0,0,0.4), 30)
                ui.drawLine(vec2(30,180), vec2(math.min(math.max((car.waterTemperature - 50) * 7.5, 54), 300),180), rgbm(1,1 - ((car.waterTemperature - 60) / 40  ),0,0.75), 30)


                ui.setCursorX(40)
                ui.setCursorY(30)

                ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(250,150))

                ui.pushFont(ui.Font.Huge)
                ui.setCursorX(108 + 2)
                ui.setCursorY(70 + 2)
                ui.textColored('TEMP', rgbm(0.1,0.8,1,0.7))

                ui.pushFont(ui.Font.Huge)
                ui.setCursorX(108 + 1)
                ui.setCursorY(70 + 1)
                ui.textColored('TEMP', rgbm(0.8,0,1,1))

                ui.pushFont(ui.Font.Huge)
                ui.setCursorX(108)
                ui.setCursorY(70)
                ui.textColored('TEMP', rgbm(0.8,0,1,1))


            end)


        end)

    end

    if showMessageRefuel0 or showMessageRefuel1 then
        ui.transparentWindow('RefuelMessage', vec2(1920 / 2 - 350, 100), vec2(700,1080 - 100), function ()
            ui.pushFont(ui.Font.Huge)
            if showMessageRefuel1 then
                ui.textAligned('Refueling...', 0.14, vec2(1920,0))
            elseif showMessageRefuel0 then
                ui.textAligned('Press [SPACEBAR] to refuel car', 0.02, vec2(1920,0))
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
        ui.transparentWindow('RepairMessage', vec2(1920 / 2 - 350, 100), vec2(700,1080 - 100), function ()
            ui.pushFont(ui.Font.Huge)
            if showMessageRepair1 then
                ui.textAligned('Car Repaired!', 0.13, vec2(1920,0))
            elseif showMessageRepair0 or showMessageRepair0S then
                if showMessageRepair0 then
                    ui.pushFont(ui.Font.Huge)
                    ui.textAligned('Press [SPACEBAR] to repair car', 0.02, vec2(1920,0))
                elseif showMessageRepair0S then
                    ui.pushFont(ui.Font.Huge)
                    ui.textAligned('Press [SPACEBAR] to repair car', 0.02, vec2(1920,0))
                    ui.pushFont(ui.Font.Title)
                    ui.textAligned('Secret Car Repair Shop', 0.14, vec2(1920,0))
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
        ui.transparentWindow('TowRefuelMessage', vec2(0 + (1920 * 0.2), 100), vec2(1920 / 1.2,1080 - 100), function ()
            ui.pushFont(ui.Font.Huge)
            if showMessageERefuel0 then
                ui.textAligned('Press [SPACEBAR] for tow truck to bring 5 liters of fuel.', 0, vec2(1920,0))
                ui.textAligned('Estimated wait time in minutes is:', 0.1, vec2(1920,0))

                ui.setCursorX(1920 * 0.43)
                ui.setCursorY(80.99)
                ui.text(fueltimewait)
            end
            if showMessageERefuel3 and showMessageERefuelClock + 5 > os.clock() then
                ui.textAligned('Emergency Fuel Canceled', 0.22, vec2(1920,0))
            elseif showMessageERefuel2 and showMessageERefuelClock + 5 > os.clock() then
                ui.textAligned('Fuel Delivered!', 0.25, vec2(1920,0))
            elseif showMessageERefuel1 then
                ui.textAligned('Tow truck is on the way, please wait in the general area.', 0, vec2(1920,0))
                ui.textAligned('DO NOT DISCONNECT FROM THE SERVER.', 0.1, vec2(1920,0))

                ui.pushFont(ui.Font.Title)
                ui.textAligned('Press [CTRL] + [SHIFT] + [TAB] to cancel at any time.', 0.22, vec2(1920,0))
            end
            if showMessageERefuel3 and showMessageERefuelClock + 5 < os.clock() and showMessageERefuelClock + 10 > os.clock() or showMessageERefuel2 and showMessageERefuelClock + 5 < os.clock() and showMessageERefuelClock + 10 > os.clock() then
                showMessageERefuel3 = false
                showMessageERefuel2 = false
                showMessageERefuel1 = false
            end
        end)
    end

    if showMessageERepair0 or showMessageERepair1 or showMessageERepair2 then
        ui.transparentWindow('TowMessage', vec2(0 + (1920 * 0.1), 100), vec2(1920 / 1.1,1080 - 100), function ()
            ui.pushFont(ui.Font.Huge)
            if showMessageERepair0 then
                ui.textAligned('Do you want a tow? Press [SPACE] to confirm or [CTRL] to cancel.', 0.1, vec2(1920,0))
                ui.textAligned('Estimated wait time in minutes is:', 0.25, vec2(1920,0))

                ui.setCursorX(1920 * 0.55)
                ui.setCursorY(80.99)
                ui.text(timewait)
            end
            if showMessageERepair2 and showMessageERepairClock + 5 > os.clock() then
                ui.textAligned('Tow Service Canceled', 0.35, vec2(1920,0))
            elseif showMessageERepair1 then
                ui.textAligned('Tow truck is on the way, please wait in the general area.', 0.25, vec2(1920,0))
                ui.textAligned('DO NOT DISCONNECT FROM THE SERVER.', 0.31, vec2(1920,0))

                ui.pushFont(ui.Font.Title)
                ui.textAligned('Press [CTRL] + [SHIFT] + [TAB] to cancel at any time.', 0.38, vec2(1920,0))
            end
            if showMessageERepair2 and showMessageERepairClock + 5 < os.clock() and showMessageERepairClock + 10 > os.clock() then
                showMessageERepair2 = false
                showMessageERepair1 = false
                showMessageERepair0 = false
            end
        end)
    end

    if showMessageToll0 or showMessageToll1 or showMessageToll2 or showMessageToll3 or showMessageToll4 or showMessageToll5 then
        ui.transparentWindow('TollMessage', vec2(0 + (1920 * 0.1), 100), vec2(1920 / 1.1,1080 - 100), function ()
            ui.pushFont(ui.Font.Huge)
            if showMessageToll0 and showMessageTollClock + 5 > os.clock() then
                ui.textAligned('Payment Accepted, Have a Great Day!', 0.35, vec2(1920,0))
            elseif showMessageToll0 and showMessageTollClock + 6 < os.clock() then
                showMessageToll0 = false
            elseif showMessageToll3 then
                ui.textAligned('Processing Please Wait...', 0.36, vec2(1920,0))
            elseif showMessageToll4 then
                ui.textAligned('Press [SPACE] to Pay the Toll', 0.35, vec2(1920,0))
            elseif showMessageToll5 then
                ui.textAligned('Please Stop at the Toll Booth Ahead', 0.33, vec2(1920,0))
            end
    
    
            if showMessageToll1 and showMessageTollClock + 5 > os.clock() then
                ui.textAligned('ETC Card Error. Please Back Up and Try Again.', 0.32, vec2(1920,0))
            elseif showMessageToll1 and showMessageTollClock + 6 < os.clock() then
                showMessageToll1 = false
            end
            if showMessageToll2 and showMessageTollClock + 5 > os.clock() then
                ui.textAligned('ETC Card Error. Please stop at the toll booth to pay.', 0.25, vec2(1920,0))
            elseif showMessageToll2 and showMessageTollClock + 6 < os.clock() then
                showMessageToll2 = false
            end
    
        end)
    end

    if showTollFine == 1 then
        ui.transparentWindow('TollMessage', vec2(0 + (1920 * 0.1), 100), vec2(1920 / 1.1,1080 - 100), function ()
            ui.pushFont(ui.Font.Huge)
            ui.textAligned('Toll booth skipped, penalty for 30 seconds...', 0.25, vec2(1920,0))

        end)
    end

    if died == 1 then
        
        physics.setGentleStop(0, true)
        
        MainMenu = 1
        ui.transparentWindow('DIED', vec2(-20, -20), ui.windowSize() + vec2(20,20), function ()

            ui.pushFont(ui.Font.Huge)
            ui.childWindow('died', ui.windowSize() + vec2(20,20), false, ui.WindowFlags.None, function ()


                ui.setCursorX(0)
                ui.setCursorY(0)

                ui.image('https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/b6c50ee6-a1c2-471d-8b18-31ad972d7149/dbn9k39-c83efb73-74a9-41ee-951f-0c1caf158373.png/v1/fill/w_960,h_540/blood_vignette_by_7he1ndigo_dbn9k39-fullview.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NTQwIiwicGF0aCI6IlwvZlwvYjZjNTBlZTYtYTFjMi00NzFkLThiMTgtMzFhZDk3MmQ3MTQ5XC9kYm45azM5LWM4M2VmYjczLTc0YTktNDFlZS05NTFmLTBjMWNhZjE1ODM3My5wbmciLCJ3aWR0aCI6Ijw9OTYwIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.HuHva8oUTCbpfhV6_Q7dF87ZVngsUezGsZTSx3Mn5Ts',ui.windowSize() + vec2(20,20))

                ui.drawRectFilled(vec2(-20, -20), ui.windowSize() + vec2(20,20), rgbm(0,0,0,(os.clock() * 1 - diedTime) - 10), 55)

                ui.setCursorX(350)
                ui.setCursorY(230)
                ui.dwriteTextAligned('GAME OVER!', 150, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(1,0,0,(os.clock() * 1 - diedTime) - 10))
        
                if diedTime + 11 < os.clock() then
                    ui.setCursor(ui.windowSize() / 2.45)
                    if ui.button('    ', vec2(300,150)) then
                        
                    end
            
                    ui.setCursorX(350)
                    ui.setCursorY(490)
                    ui.dwriteTextAligned('RESET', 60, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(1,0,0,1))
        
                    ui.setCursorX(350)
                    ui.setCursorY(620)
                    ui.dwriteTextAligned('(you cannot respawn in mortal mode)', 30, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(1,0,0,1))
        

                end

                

            end)


        end)

        if diedTime + 1 > os.clock() then
            if DeathPlayerChance == 0 then
                DeathSound0:play()
            elseif DeathPlayerChance == 1 then
                DeathSound1:play()
            elseif DeathPlayerChance == 2 then
                DeathSound2:play()
            end
        end

        


    end

end

local transferMoney = ac.OnlineEvent({
    -- message structure layout:
    person = ac.StructItem.string(50),
    money = ac.StructItem.float(),
  }, function (sender, data)
    -- got a message from other client (or ourselves; in such case `sender.index` would be 0):
    if data.person == ac.getDriverName(0) then
        ac.debug('Got from:', data.person)
        ac.debug('Got money:', data.money)
        money = money + data.money
        data.money = 0
    end
  end)

function TransferMoney()

    transferMoney{ person = ac.getDriverName(TransferPersonType), money = moneyTransfer }

end
