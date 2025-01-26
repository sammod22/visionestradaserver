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
    tempEnabled = 0
}

local fpsClock = os.clock()
local initialLaunch = false

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
        tempEnabled = storedValues.tempEnabled
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
            storedValues.tempEnabled = tempEnabled
            if enginedamageFirstLoad + 10 > os.clock() then
                storedValues.engineDamage = engineDamage
                physics.setCarEngineLife(0, engineDamage)
            else
                storedValues.engineDamage = car.engineLifeLeft
            end

        end
        Fuel()
        TollManagement()
        SaveCarPosition()

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

local mainMenu = 0
local mainMenuToggle = 0
local stickColor = rgbm(0.3,0.3,0.3,1)
local stickColorGroove = rgbm(0.25,0.25,0.25,1)
local sticktoggle = false
local sticktoggleadd = 0
local sticktoggled = false
local oilcaptoggled = false
local oilSnapped = false
local oilPouring = false
local oilDraining = false

local menuState = 0

local carArrayX = {}
local carArrayZ = {}

function script.drawUI()

    uiState = ac.getUI()

    local simstate = ac.getSim()
    local playerCarStates

    if mainMenu > 1 then
        mainMenu = 0
    end

    if ac.isKeyDown(121) and not mainMenuToggle then
        mainMenu = mainMenu + 1
        mainMenuToggle = true
    end

    if mainMenuToggle and not ac.isKeyDown(121) then
        mainMenuToggle = false
    end


    if mainMenu == 0 then

        if car.speedKmh < 5 then
            physics.setCarNoInput(true)
        end

        if  menuState == 0 then
        
            ui.toolWindow('Main Menu', vec2(0, 0), vec2(uiState.windowSize.x,uiState.windowSize.y), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('mainmenu', vec2(uiState.windowSize.x, uiState.windowSize.y), false, ui.WindowFlags.None, function ()


                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))


                    --- MAIN MENU ---

                    ui.setCursorX(uiState.windowSize.y / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.y / 2 + 270 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('MAIN MENU', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.y / 2 + 270 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('MAIN MENU', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.y / 2 + 270)
                    ui.setCursorY(29)
                    ui.textColored('MAIN MENU', rgbm(0.8,0,1,1))

                    --- SRP MAP ---

                    ui.setCursorX(uiState.windowSize.y / 2 + 100)
                    ui.setCursorY(180)

                    ui.image('https://i.postimg.cc/KYjNJhzp/map-mini.png',vec2(554,819))

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(730)
                    ui.setCursorY(280)
                    ui.textColored('FUEL/REPAIR', rgbm(1,0.5,0,1))

                    ui.drawCircle(vec2(842,315), 5, rgbm(1,0.5,0,1), 30, 10)


                    --- OTHER PLAYERS ---
                    

                    for i = 2, simstate.carsCount do
                        playerCarStates = ac.getCarState(i)
                        if playerCarStates ~= nil and playerCarStates.isConnected then
                            carArrayX[i] = playerCarStates.position.x
                            carArrayZ[i] = playerCarStates.position.z
                            if carArrayX[i] ~= 0 then
                                ui.drawCircle(vec2((uiState.windowSize.x / 2) +  carArrayX[i] / 33 + 22, (uiState.windowSize.y / 2) +  carArrayZ[i] / 33 -50), 5, rgbm(0.6,0,1,1), 30, 15)
                            end
                        end
                
                    end

                    --- YOU ARE HERE ---

                    ui.drawCircle(vec2((uiState.windowSize.x / 2) + car.position.x / 33 + 22, (uiState.windowSize.y / 2) + car.position.z / 33 -50), 5, rgbm(1,0,0,1), 30, 15)
                    
                    ui.setCursorX((uiState.windowSize.x / 2) + car.position.x / 33 + 22 + 20)
                    ui.setCursorY((uiState.windowSize.y / 2) + car.position.z / 33 -50 - 35)
                    ui.pushFont(ui.Font.Title)

                    ui.textColored('YOU ARE HERE', rgbm(1,0,0,1))



                    ---
                    

                    ui.setCursorX(0)
                    ui.setCursorY(100)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(65 + 2)
                    ui.setCursorY(215 + 2)
                    ui.textColored('MORE SOON', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(65 + 1)
                    ui.setCursorY(215 + 1)
                    ui.textColored('MORE SOON', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(65)
                    ui.setCursorY(215)
                    ui.textColored('MORE SOON', rgbm(0.8,0,1,1))



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
                        menuState = 3
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
                        menuState = 2
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
                        menuState = 1
                    end

                    ui.setCursorX(uiState.windowSize.x - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.x - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.x - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.x - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(uiState.windowSize.x - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('menuquit', vec2(340,130)) then
                        mainMenu = mainMenu + 1
                    end


                end)


            end)
        
        elseif menuState == 1 then

            ui.toolWindow('Settings', vec2(0, 0), vec2(uiState.windowSize.x,uiState.windowSize.y), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('setting', vec2(uiState.windowSize.x, uiState.windowSize.y), false, ui.WindowFlags.None, function ()

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))


                    --- SETTINGS ---

                    ui.setCursorX(uiState.windowSize.y / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.y / 2 + 300 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('SETTINGS', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.y / 2 + 300 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('SETTINGS', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.y / 2 + 300)
                    ui.setCursorY(29)
                    ui.textColored('SETTINGS', rgbm(0.8,0,1,1))

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


                    --- BACK ---

                    ui.setCursorX(uiState.windowSize.x - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.x - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.x - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.x - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(uiState.windowSize.x - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        menuState = 0
                    end


                end)


            end)

        elseif menuState == 2 then

            ui.toolWindow('Services', vec2(0, 0), vec2(uiState.windowSize.x,uiState.windowSize.y), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('service', vec2(uiState.windowSize.x, uiState.windowSize.y), false, ui.WindowFlags.None, function ()

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))


                    --- SERVICES ---

                    ui.setCursorX(uiState.windowSize.y / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.y / 2 + 302 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('SERVICES', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.y / 2 + 302 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('SERVICES', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.y / 2 + 302)
                    ui.setCursorY(29)
                    ui.textColored('SERVICES', rgbm(0.8,0,1,1))

                    ui.setCursorX(0)
                    ui.setCursorY(100)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(142 + 2)
                    ui.setCursorY(215 + 2)
                    ui.textColored('TOW', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(142 + 1)
                    ui.setCursorY(215 + 1)
                    ui.textColored('TOW', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(142)
                    ui.setCursorY(215)
                    ui.textColored('TOW', rgbm(0.8,0,1,1))

                    ui.setCursorX(30)
                    ui.setCursorY(185)

                    if ui.invisibleButton('towservice', vec2(340,210)) then
                        calledMechanic = true
                    end

                    ui.setCursorX(400)
                    ui.setCursorY(140)

                    ui.image('https://i.postimg.cc/T2LsTgTN/UI-PANELS-PURPLE.png',vec2(500,300))

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(465)
                    ui.setCursorY(215)
                    ui.textColored('Teleports you to the repair shop in case car is', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(465)
                    ui.setCursorY(240)
                    ui.textColored('damaged. Use this if you get stuck as well.', rgbm(0.8,0,1,1))


                    ui.setCursorX(0)
                    ui.setCursorY(400)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(145 + 2)
                    ui.setCursorY(515 + 2)
                    ui.textColored('FUEL', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(145 + 1)
                    ui.setCursorY(515 + 1)
                    ui.textColored('FUEL', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(145)
                    ui.setCursorY(515)
                    ui.textColored('FUEL', rgbm(0.8,0,1,1))

                    ui.setCursorX(30)
                    ui.setCursorY(485)

                    if ui.invisibleButton('fuelservice', vec2(340,210)) then
                        physics.setCarPosition(0, vec3(-4515.52, 34.75, -6014.95), ac.getCameraDirection())
                    end

                    ui.setCursorX(400)
                    ui.setCursorY(440)

                    ui.image('https://i.postimg.cc/T2LsTgTN/UI-PANELS-PURPLE.png',vec2(500,300))

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(465)
                    ui.setCursorY(515)
                    ui.textColored('Teleports you to the fuel station in case car is', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Title)
                    ui.setCursorX(465)
                    ui.setCursorY(540)
                    ui.textColored('out of fuel.', rgbm(0.8,0,1,1))



                    --- BACK ---

                    ui.setCursorX(uiState.windowSize.x - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.x - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.x - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.x - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(uiState.windowSize.x - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        menuState = 0
                    end


                end)


            end)

        elseif menuState == 3 then

            ui.toolWindow('ENGINES', vec2(0, 0), vec2(uiState.windowSize.x,uiState.windowSize.y), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('Engine', vec2(uiState.windowSize.x, uiState.windowSize.y), false, ui.WindowFlags.None, function ()

                    ui.setCursorX(100)
                    ui.setCursorY(-40)

                    ui.image('https://i.postimg.cc/g0F570Ct/badge1.png',vec2(200,200))


                    --- SERVICES ---

                    ui.setCursorX(uiState.windowSize.y / 2 + 150)
                    ui.setCursorY(-190)

                    ui.image('https://i.postimg.cc/907g15xH/HEXAGON-BUTTON-PURPLE.png',vec2(500,500))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.y / 2 + 302 + 2)
                    ui.setCursorY(29 + 2)
                    ui.textColored('ENGINE', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.y / 2 + 302 + 1)
                    ui.setCursorY(29 + 1)
                    ui.textColored('ENGINE', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.y / 2 + 302)
                    ui.setCursorY(29)
                    ui.textColored('ENGINE', rgbm(0.8,0,1,1))




                    if not sticktoggled then

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
    
                        if ui.invisibleButton('CHECK OIL', vec2(150,80)) and not oilSnapped then
                            sticktoggled = true
                        end
    
                        if oilcaptoggled then
    
                            ui.drawCircle(vec2(250,280), 10, rgbm(0.02,0.02,0.02,1), 40, 20)
                            ui.drawCircle(vec2(250,280), 22, rgbm(0.07,0.07,0.07,1), 40, 8)
                            ui.drawCircle(vec2(250,280), 27, rgbm(0.1,0.1,0.1,1), 40, 8)
                            ui.drawCircle(vec2(250,280), 32, rgbm(0.13,0.13,0.13,1), 40, 8)
                            ui.drawCircle(vec2(250,280), 37, rgbm(0.17,0.17,0.17,1), 40, 8)
                            ui.drawCircle(vec2(250,280), 42, rgbm(0.2,0.2,0.2,1), 40, 8)
    
                            if oilAmount > 150 then
                                ui.drawCircle(vec2(250,280), 10, rgbm(0.32,0.32,0,(math.abs(150 - math.max(150, oilAmount)))/150 * 5), 40, math.max(20, oilAmount - 130))
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
                                ui.setCursorY(295)
                                ui.invisibleButton('OIL FILL', vec2(80,270))
    
                                if ui.itemHovered() and oilAmount < 170 then
                                    oilPouring = true
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
                                    oilPouring = false
                                end
    
                                ui.setCursorX(ui.mouseLocalPos().x - 40)
                                ui.setCursorY(ui.mouseLocalPos().y - 60)
                                if ui.invisibleButton('OIL BOTTLE', vec2(110,340)) and not oilPouring then
                                    oilSnapped = false
                                end
    
                            else
                                ui.setCursorX(795)
                                ui.setCursorY(600)
                                if ui.invisibleButton('OIL BOTTLE', vec2(110,340)) then
                                    oilSnapped = true
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
                            if oilcaptoggled then
                                oilcaptoggled = false
                            else
                                oilcaptoggled = true
                            end
                        end

                        ui.drawRectFilled(vec2(335,230), vec2(456,335), rgbm(1,1,1,0.1), 0, 10)
                        
                        
    
                        ui.setCursorX(350)
                        ui.setCursorY(230)
    
                        if ui.invisibleButton('OIL DRAIN', vec2(90,310)) then
                            if oilDraining or oilAmount < 0.1 then
                                oilDraining = false
                            else
                                oilDraining = true
                                
                            end
                        end
    
                        if oilDraining then
                            ui.setCursorX(351)
                            ui.setCursorY(310)
                            ui.textColored('DRAINING...', rgbm(0.0,0.0,0.0,1)) 
                            oilAmount = oilAmount - 0.01
                        else
                            ui.setCursorX(368)
                            ui.setCursorY(310)
                            ui.textColored('DRAIN', rgbm(0.0,0.0,0.0,1))    
                        end
    
                        if oilAmount < 0.1 and oilDraining then
                            oilDraining = false
                            oilAmount = 0
                            oilQuality = 100
                        end
    
                        ui.setCursorX(360)
                        ui.setCursorY(225)
                        ui.image('https://cdn4.iconfinder.com/data/icons/automotive-maintenance/100/automotive-oil-drain-pan2-512.png',vec2(70,90))
    
                        
    
                    
                    end
    
                    if sticktoggled then
                        
                        ui.drawLine(vec2(100,300), vec2(600,300), stickColor, 40)
                        ui.drawTriangle(vec2(600,300.5), vec2(600,300.5), vec2(680,300.5), stickColor, 40)
                        ui.drawLine(vec2(630,300), vec2(730,300), stickColor, 10)
    
                        -- markers
    
                        ui.pushFont(ui.Font.Title)
                        ui.setCursorX(275)
                        ui.setCursorY(287)
                        ui.textColored('MAX',stickColorGroove)
                        ui.drawLine(vec2(560,280), vec2(560,320), stickColorGroove, 2)
                        ui.drawLine(vec2(320,280), vec2(320,320), stickColorGroove, 2)
    
                        -- detail lines
    
                        ui.drawLine(vec2(320,300), vec2(340,320), stickColorGroove, 2)
                        ui.drawLine(vec2(320,300), vec2(340,280), stickColorGroove, 2)
    
                        ui.drawLine(vec2(320,280), vec2(360,320), stickColorGroove, 2)
                        ui.drawLine(vec2(340,280), vec2(380,320), stickColorGroove, 2)
                        ui.drawLine(vec2(360,280), vec2(400,320), stickColorGroove, 2)
                        ui.drawLine(vec2(380,280), vec2(420,320), stickColorGroove, 2)
                        ui.drawLine(vec2(400,280), vec2(440,320), stickColorGroove, 2)
                        ui.drawLine(vec2(420,280), vec2(460,320), stickColorGroove, 2)
                        ui.drawLine(vec2(440,280), vec2(480,320), stickColorGroove, 2)
                        ui.drawLine(vec2(460,280), vec2(500,320), stickColorGroove, 2)
                        ui.drawLine(vec2(480,280), vec2(520,320), stickColorGroove, 2)
                        ui.drawLine(vec2(500,280), vec2(540,320), stickColorGroove, 2)
                        ui.drawLine(vec2(520,280), vec2(560,320), stickColorGroove, 2)
    
                        ui.drawLine(vec2(320,320), vec2(360,280), stickColorGroove, 2)
                        ui.drawLine(vec2(340,320), vec2(380,280), stickColorGroove, 2)
                        ui.drawLine(vec2(360,320), vec2(400,280), stickColorGroove, 2)
                        ui.drawLine(vec2(380,320), vec2(420,280), stickColorGroove, 2)
                        ui.drawLine(vec2(400,320), vec2(440,280), stickColorGroove, 2)
                        ui.drawLine(vec2(420,320), vec2(460,280), stickColorGroove, 2)
                        ui.drawLine(vec2(440,320), vec2(480,280), stickColorGroove, 2)
                        ui.drawLine(vec2(460,320), vec2(500,280), stickColorGroove, 2)
                        ui.drawLine(vec2(480,320), vec2(520,280), stickColorGroove, 2)
                        ui.drawLine(vec2(500,320), vec2(540,280), stickColorGroove, 2)
                        ui.drawLine(vec2(520,320), vec2(560,280), stickColorGroove, 2)
    
                        ui.drawLine(vec2(540,320), vec2(560,300), stickColorGroove, 2)
                        ui.drawLine(vec2(540,280), vec2(560,300), stickColorGroove, 2)
    
    
    
                        ui.drawLine(vec2((600 - (oilAmount * 2.8)),300), vec2(600,300), oilColor, 35)
                        ui.drawTriangle(vec2(600,300.5), vec2(600,300.5), vec2(680,300.5), oilColor, 35)
                        ui.drawLine(vec2(660,300), vec2(730,300), oilColor, 8)
    
                        ui.setCursorX(90)
                        ui.setCursorY(270)
    
                        if ui.invisibleButton('CHECK OIL', vec2(650,260)) then
                            sticktoggled = false
                        end
    
                    end




                    --- BACK ---

                    ui.setCursorX(uiState.windowSize.x - 450)
                    ui.setCursorY(700)

                    ui.image('https://i.postimg.cc/T3qSZxTR/RECTANGLE-BUTTON-PRUPLE.png',vec2(400,300))


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.x - 300 + 2)
                    ui.setCursorY(815 + 2)
                    ui.textColored('BACK', rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.x - 300 + 1)
                    ui.setCursorY(815 + 1)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(uiState.windowSize.x - 300)
                    ui.setCursorY(815)
                    ui.textColored('BACK', rgbm(0.8,0,1,1))

                    ui.setCursorX(uiState.windowSize.x - 420)
                    ui.setCursorY(786)

                    if ui.invisibleButton('', vec2(340,130)) then
                        menuState = 0
                    end


                end)


            end)


        end
    else
        physics.setCarNoInput(false)

    end

    if mainMenu == 1 and tempEnabled == 1 then

        ui.transparentWindow('TEMPWINDOW', vec2(0, 0), vec2(uiState.windowSize.x / 3,uiState.windowSize.y / 3 ), function ()

            ui.pushFont(ui.Font.Huge)
            ui.childWindow('temp', vec2(uiState.windowSize.x / 3, uiState.windowSize.y / 3), false, ui.WindowFlags.None, function ()


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

    if showTollFine == 1 then
        ui.transparentWindow('TollMessage', vec2(0 + (uiState.windowSize.x * 0.1), 100), vec2(uiState.windowSize.x / 1.1,uiState.windowSize.y - 100), function ()
            ui.pushFont(ui.Font.Huge)
            ui.textAligned('Toll booth skipped, penalty for 30 seconds...', 0.25, vec2(uiState.windowSize.x,0))

        end)
    end

end
