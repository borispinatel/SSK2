-- =============================================================
-- Copyright Roaming Gamer, LLC. 2008-2016 (All Rights Reserved)
-- =============================================================

-- =============================================================
-- Localizations
-- =============================================================
-- Lua
local getTimer = system.getTimer; local mRand = math.random
local mAbs = math.abs;local mRand = math.random;local mDeg = math.deg;
local mRad = math.rad;local mCos = math.cos;local mSin = math.sin;
local mAcos = math.acos;local mAsin = math.asin;local mSqrt = math.sqrt;
local mCeil = math.ceil;local mFloor = math.floor;local mAtan2 = math.atan2;

local strMatch = string.match; local strGSub = string.gsub; local strSub = string.sub
--
-- Common SSK Display Object Builders
local newCircle = ssk.display.newCircle;local newRect = ssk.display.newRect
local newImageRect = ssk.display.newImageRect;local newSprite = ssk.display.newSprite
local quickLayers = ssk.display.quickLayers
--
-- Common SSK Helper Modules
local easyIFC = ssk.easyIFC;local persist = ssk.persist
--
-- Common SSK Helper Functions
local isValid = display.isValid;local isInBounds = ssk.easyIFC.isInBounds
local normRot = math.normRot;local easyAlert = ssk.misc.easyAlert
--
-- SSK 2D Math Library
local addVec = ssk.math2d.add;local subVec = ssk.math2d.sub;local diffVec = ssk.math2d.diff
local lenVec = ssk.math2d.length;local len2Vec = ssk.math2d.length2;
local normVec = ssk.math2d.normalize;local vector2Angle = ssk.math2d.vector2Angle
local angle2Vector = ssk.math2d.angle2Vector;local scaleVec = ssk.math2d.scale
ssk.misc.countLocals(1)

-- =============================================================
-- =============================================================

local RGTiled = ssk.tiled

-- =============================================================
local test = {}

function test.run( group, params )
   group = group or display.currentStage
   params = params or {}

   -- Create some basic layers.
   --
   local layers = quickLayers( group, 
         "underlay",
         "world",
            { "background", "content", "foreground" },
         "overlay" )   

   --table.dump(RGTiled, nil, "RGTiled")   
   local level = RGTiled.new()
   
   --table.dump(level, nil, "level")   
   level.setLevelsPath( "tests/tiled" )

   level.load( "dummy", {} )

   --table.dump(level, nil, "level loaded")   

   local objects = level.getRecords()
   table.dump(objects,nil,"objects")

   local images = level.getImages()
   table.dump(images,nil,"images")

   local function simpleSpinner( obj )
   	obj.rotation = 0
   	obj.onComplete = simpleSpinner
   	local rec = obj.rec
   	local properties = obj.rec.properties
   	transition.to( obj, { rotation = 360, time = properties.rotTime or 1000, onComplete = obj } )
   end

   local function func( rec, num )
   	local img = level.getImage( rec.gid )
   	local obj = newImageRect( layers[rec.layer], rec.x, rec.y, img.image, 
   		{ w = rec.width, h = rec.height, rec = rec }  )
   	if( rec.flip.x ) then obj.xScale = -obj.xScale end
   	if( rec.flip.y ) then obj.yScale = -obj.yScale end
   	--table.dump(rec)

   	if(rec.name == "spinner") then
   		simpleSpinner( obj )
   	end
	end

   level.forEach( func )
end

return test
