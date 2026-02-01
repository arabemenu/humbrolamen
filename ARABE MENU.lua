ADMIN_MODE = false
project = {
    pName = "MENU DOS CRIA",
    pType = "Project",
    pTag = "()"
}
script_name(string.format(project.pName .. " " .. project.pType))
script_version(1)
local vu1 = require("samp.raknet")
local vu2 = require("imgui")
require("copas.http")
require("copas")
local vu3 = require("os")
local vu6 = require("sampfuncs")
local vu7 = require("game.weapons")
local vu8 = require("fAwesome5")
local vu9 = require("memory")
local vu10 = require("ffi")
local vu11 = vu10.cast("int (__thiscall*)(void*, float*, int, bool)", 6177408)
local _ = require("moonloader").font_flag
local vu12 = require("vkeys")
local sampev = require("lib.samp.events")
local v13 = require("samp.events")
local vu14 = require("samp.events.bitstream_io")
local vu15 = require("samp.events.handlers")
local vu16 = require("samp.events.extra_types")
local v17 = require("encoding")
local imgui = require 'imgui'
local vu200 = imgui
local fontwarp = renderCreateFont("Arial", 8, 5) -- Fonte para o ESP
local ultimoCarroId = -1
local rifaTargetActive = false
local disablePlayerSync = false
local firstTimeSitInCar = os.clock()
local airbreak = false 
local act = false
local lastInvisNotify = 0
local __GG_telagem_last = false
local runkeys = {0x41, 0x44, 0x53, 0x57} -- Teclas A, D, S, W
local GG_lista = vu200.ImBool(false)
local GG_grudarexplodir = vu200.ImBool(false)
local GG_AirStealth = vu200.ImBool(false)
local GG_bypass_tp = vu200.ImBool(false) -- Usando o formato do seu menu
local ghostMode = false                   
local estavoando = false
local farmAtivo = vu200.ImBool(false)
local aguardandoVenda = false
local POS_PESCA = { x = 2101.5098, y = -103.8489, z = 2.3464, a = 137.0436 }
local POS_VENDA = { x = -146.2664, y = -217.2210, z = 1.4297, a = 83.8532 }
local id = -1         -- ID do jogador sendo telado
local tvActive = false
local posCongelada = {x = 0, y = 0, z = 0}
local GG_airbypass = vu200.ImBool(false)
local GG_ChecarDroides = vu200.ImBool(false)
local players_device = {}
local GG_SpeedHackBypass = vu200.ImBool(false)
local GG_AirVehBypass = vu200.ImBool(false)
local actualSpeed = -1
local distAB = 0
local oldX, oldY, oldZ = 0, 0, 0
local font_device = renderCreateFont('Arial', 8, 10)
v17.default = "CP1251"
u8 = v17.UTF8
require("lib.moonloader")
require("lib.sampfuncs")
require("lfs")
as_action = require("moonloader").audiostream_state
local font_bypass = renderCreateFont('Century Gothic', 12, 5)
musicselected = 1
stats1 = "nil"
stats2 = "nil"
pAnimationWalk = {
    "WALK_PLAYER",
    "GUNCROUCHFWD",
    "GUNCROUCHBWD",
    "GUNMOVE_BWD",
    "GUNMOVE_FWD",
    "GUNMOVE_L",
    "GUNMOVE_R",
    "RUN_GANG1",
    "JOG_FEMALEA",
    "JOG_MALEA",
    "RUN_CIVI",
    "RUN_CSAW",
    "RUN_FAT",
    "RUN_FATOLD",
    "RUN_OLD",
    "RUN_ROCKET",
    "RUN_WUZI",
    "SPRINT_WUZI",
    "WALK_ARMED",
    "WALK_CIVI",
    "WALK_CSAW",
    "WALK_DRUNK",
    "WALK_FAT",
    "WALK_FATOLD",
    "WALK_GANG1",
    "WALK_GANG2",
    "WALK_OLD",
    "WALK_SHUFFLE",
    "WALK_START",
    "WALK_START_ARMED",
    "WALK_START_CSAW",
    "WALK_START_ROCKET",
    "WALK_WUZI",
    "WOMAN_WALKBUSY",
    "WOMAN_WALKFATOLD",
    "WOMAN_WALKNORM",
    "WOMAN_WALKOLD",
    "WOMAN_RUNFATOLD",
    "WOMAN_WALKPRO",
    "WOMAN_WALKSEXY",
    "WOMAN_WALKSHOP",
    "RUN_1ARMED",
    "RUN_ARMED",
    "RUN_PLAYER",
    "WALK_ROCKET",
    "CLIMB_IDLE",
    "MUSCLESPRINT",
    "CLIMB_PULL",
    "CLIMB_STAND",
    "CLIMB_STAND_FINISH",
    "SWIM_BREAST",
    "SWIM_CRAWL",
    "SWIM_DIVE_UNDER",
    "SWIM_GLIDE",
    "MUSCLERUN",
    "WOMAN_RUN",
    "WOMAN_RUNBUSY",
    "WOMAN_RUNPANIC",
    "WOMAN_RUNSEXY",
    "SPRINT_CIVI",
    "SPRINT_PANIC",
    "SWAT_RUN",
    "FATSPRINT"
}
pAnimationDeagle = {
    "PYTHON_CROUCHFIRE",
    "PYTHON_FIRE",
    "PYTHON_FIRE_POOR"
}
pOverdoseAnimations = {
    "CRCKIDLE4",
    "CRCKIDLE2",
    "CRCKDETH2"
}
pGunsAnimations = {
    "PYTHON_CROUCHFIRE",
    "PYTHON_FIRE",
    "PYTHON_FIRE_POOR",
    "PYTHON_CROCUCHRELOAD",
    "RIFLE_CROUCHFIRE",
    "RIFLE_CROUCHLOAD",
    "RIFLE_FIRE",
    "RIFLE_FIRE_POOR",
    "RIFLE_LOAD",
    "SHOTGUN_CROUCHFIRE",
    "SHOTGUN_FIRE",
    "SHOTGUN_FIRE_POOR",
    "SILENCED_CROUCH_RELOAD",
    "SILENCED_CROUCH_FIRE",
    "SILENCED_FIRE",
    "SILENCED_RELOAD",
    "TEC_crouchfire",
    "TEC_crouchreload",
    "TEC_fire",
    "TEC_reload",
    "UZI_crouchfire",
    "UZI_crouchreload",
    "UZI_fire",
    "UZI_fire_poor",
    "UZI_reload",
    "idle_rocket",
    "Rocket_Fire",
    "run_rocket",
    "walk_rocket",
    "WALK_start_rocket",
    "WEAPON_sniper"
}
packet_animation = {
    "WALK_PLAYER",
    "GUNCROUCHFWD",
    "GUNCROUCHBWD",
    "GUNMOVE_BWD",
    "GUNMOVE_FWD",
    "GUNMOVE_L",
    "GUNMOVE_R",
    "RUN_GANG1",
    "JOG_FEMALEA",
    "JOG_MALEA",
    "RUN_CIVI",
    "RUN_CSAW",
    "RUN_FAT",
    "RUN_FATOLD",
    "RUN_OLD",
    "RUN_ROCKET",
    "RUN_WUZI",
    "SPRINT_WUZI",
    "WALK_ARMED",
    "WALK_CIVI",
    "WALK_CSAW",
    "WALK_DRUNK",
    "WALK_FAT",
    "WALK_FATOLD",
    "WALK_GANG1",
    "WALK_GANG2",
    "WALK_OLD",
    "WALK_SHUFFLE",
    "WALK_START",
    "WALK_START_ARMED",
    "WALK_START_CSAW",
    "WALK_START_ROCKET",
    "WALK_WUZI",
    "WOMAN_WALKBUSY",
    "WOMAN_WALKFATOLD",
    "WOMAN_WALKNORM",
    "WOMAN_WALKOLD",
    "WOMAN_RUNFATOLD",
    "WOMAN_WALKPRO",
    "WOMAN_WALKSEXY",
    "WOMAN_WALKSHOP",
    "RUN_1ARMED",
    "RUN_ARMED",
    "RUN_PLAYER",
    "WALK_ROCKET",
    "CLIMB_IDLE",
    "MUSCLESPRINT",
    "CLIMB_PULL",
    "CLIMB_STAND",
    "CLIMB_STAND_FINISH",
    "SWIM_BREAST",
    "SWIM_CRAWL",
    "SWIM_DIVE_UNDER",
    "SWIM_GLIDE",
    "MUSCLERUN",
    "WOMAN_RUN",
    "WOMAN_RUNBUSY",
    "WOMAN_RUNPANIC",
    "WOMAN_RUNSEXY",
    "SPRINT_CIVI",
    "SPRINT_PANIC",
    "SWAT_RUN",
    "FATSPRINT"
}
vu10.cdef("\n    void Sleep(int ms);\n\n    int poll(struct pollfd *fds, unsigned long nfds, int timeout);\n\n    typedef unsigned long DWORD;\n\n    struct d3ddeviceVTBL {\n        void *QueryInterface;\n        void *AddRef;\n        void *Release;\n        void *TestCooperativeLevel;\n        void *GetAvailableTextureMem;\n        void *EvictManagedResources;\n        void *GetDirect3D;\n        void *GetDeviceCaps;\n        void *GetDisplayMode;\n        void *GetCreationParameters;\n        void *SetCursorProperties;\n        void *SetCursorPosition;\n        void *ShowCursor;\n        void *CreateAdditionalSwapChain;\n        void *GetSwapChain;\n        void *GetNumberOfSwapChains;\n        void *Reset;\n        void *Present;\n        void *GetBackBuffer;\n        void *GetRasterStatus;\n        void *SetDialogBoxMode;\n        void *SetGammaRamp;\n        void *GetGammaRamp;\n        void *CreateTexture;\n        void *CreateVolumeTexture;\n        void *CreateCubeTexture;\n        void *CreateVertexBuffer;\n        void *CreateIndexBuffer;\n        void *CreateRenderTarget;\n        void *CreateDepthStencilSurface;\n        void *UpdateSurface;\n        void *UpdateTexture;\n        void *GetRenderTargetData;\n        void *GetFrontBufferData;\n        void *StretchRect;\n        void *ColorFill;\n        void *CreateOffscreenPlainSurface;\n        void *SetRenderTarget;\n        void *GetRenderTarget;\n        void *SetDepthStencilSurface;\n        void *GetDepthStencilSurface;\n        void *BeginScene;\n        void *EndScene;\n        void *Clear;\n        void *SetTransform;\n        void *GetTransform;\n        void *MultiplyTransform;\n        void *SetViewport;\n        void *GetViewport;\n        void *SetMaterial;\n        void *GetMaterial;\n        void *SetLight;\n        void *GetLight;\n        void *LightEnable;\n        void *GetLightEnable;\n        void *SetClipPlane;\n        void *GetClipPlane;\n        void *SetRenderState;\n        void *GetRenderState;\n        void *CreateStateBlock;\n        void *BeginStateBlock;\n        void *EndStateBlock;\n        void *SetClipStatus;\n        void *GetClipStatus;\n        void *GetTexture;\n        void *SetTexture;\n        void *GetTextureStageState;\n        void *SetTextureStageState;\n        void *GetSamplerState;\n        void *SetSamplerState;\n        void *ValidateDevice;\n        void *SetPaletteEntries;\n        void *GetPaletteEntries;\n        void *SetCurrentTexturePalette;\n        void *GetCurrentTexturePalette;\n        void *SetScissorRect;\n        void *GetScissorRect;\n        void *SetSoftwareVertexProcessing;\n        void *GetSoftwareVertexProcessing;\n        void *SetNPatchMode;\n        void *GetNPatchMode;\n        void *DrawPrimitive;\n        void* DrawIndexedPrimitive;\n        void *DrawPrimitiveUP;\n        void *DrawIndexedPrimitiveUP;\n        void *ProcessVertices;\n        void *CreateVertexDeclaration;\n        void *SetVertexDeclaration;\n        void *GetVertexDeclaration;\n        void *SetFVF;\n        void *GetFVF;\n        void *CreateVertexShader;\n        void *SetVertexShader;\n        void *GetVertexShader;\n        void *SetVertexShaderConstantF;\n        void *GetVertexShaderConstantF;\n        void *SetVertexShaderConstantI;\n        void *GetVertexShaderConstantI;\n        void *SetVertexShaderConstantB;\n        void *GetVertexShaderConstantB;\n        void *SetStreamSource;\n        void *GetStreamSource;\n        void *SetStreamSourceFreq;\n        void *GetStreamSourceFreq;\n        void *SetIndices;\n        void *GetIndices;\n        void *CreatePixelShader;\n        void *SetPixelShader;\n        void *GetPixelShader;\n        void *SetPixelShaderConstantF;\n        void *GetPixelShaderConstantF;\n        void *SetPixelShaderConstantI;\n        void *GetPixelShaderConstantI;\n        void *SetPixelShaderConstantB;\n        void *GetPixelShaderConstantB;\n        void *DrawRectPatch;\n        void *DrawTriPatch;\n        void *DeletePatch;\n    };\n\n    struct d3ddevice {\n        struct d3ddeviceVTBL** vtbl;\n    };\n\n    struct stServerPresets\n    {\n        uint8_t     byteCJWalk;\n        int         m_iDeathDropMoney;\n        float        fWorldBoundaries[4];\n        bool        m_bAllowWeapons;\n        float        fGravity;\n        uint8_t     byteDisableInteriorEnterExits;\n        uint32_t    ulVehicleFriendlyFire;\n        bool        m_byteHoldTime;\n        bool        m_bInstagib;\n        bool        m_bZoneNames;\n        bool        m_byteFriendlyFire;\n        int            iClassesAvailable;\n        float        fNameTagsDistance;\n        bool        m_bManualVehicleEngineAndLight;\n        uint8_t     byteWorldTime_Hour;\n        uint8_t     byteWorldTime_Minute;\n        uint8_t     byteWeather;\n        uint8_t     byteNoNametagsBehindWalls;\n        int         iPlayerMarkersMode;\n        float        fGlobalChatRadiusLimit;\n        uint8_t     byteShowNameTags;\n        bool        m_bLimitGlobalChatRadius;\n    }__attribute__ ((packed));\n")
local vu34 = vu10.cast("struct d3ddevice*", 13204520)
local vu35 = vu10.cast("long(__stdcall*)(void*, unsigned long, unsigned long, unsigned long)", vu34.vtbl[0].SetTextureStageState)
local vu36 = vu10.cast("long(__stdcall*)(void*, unsigned long, unsigned long, unsigned int*)", vu34.vtbl[0].GetTextureStageState)
local vu37 = vu10.new("unsigned int[1]")
local vu38 = vu10.new("unsigned int[1]")
local vu39 = vu10.new("unsigned int[1]")
local vu40 = vu10.new("unsigned int[1]")
local vu41 = vu10.cast("void(__thiscall*)(void*)", 5894528)
local vu42 = {}
function AddPlayerToChamsQuery(p43, p44)
    vu42[p43] = p44
end
function RemoveFromChamsQuery(p45)
    vu42[p45] = nil
end
function onD3DPresent()
    if not (sampIsScoreboardOpen() or isPauseMenuActive()) then
        local v46, v47, v48 = pairs(vu42)
        while true do
            local v49
            v48, v49 = v46(v47, v48)
            if v48 == nil then
                break
            end
            local v50 = getCharPointer(v48)
            if v50 ~= 0 then
                if script.chamstype.v ~= 0 then
                    vu36(vu34, 0, 32, vu37)
                    vu36(vu34, 0, 26, vu38)
                    vu36(vu34, 0, 2, vu39)
                    vu36(vu34, 0, 3, vu40)
                    vu35(vu34, 0, 32, v49)
                    vu35(vu34, 0, 26, 6)
                    vu35(vu34, 0, 2, 6)
                    vu35(vu34, 0, 3, 6)
                    vu41(vu10.cast("void*", v50))
                    vu35(vu34, 0, 32, vu37[0])
                    vu35(vu34, 0, 26, vu38[0])
                    vu35(vu34, 0, 2, vu39[0])
                    vu35(vu34, 0, 3, vu40[0])
                else
                    vu36(vu34, 0, 32, vu37)
                    vu36(vu34, 0, 26, vu38)
                    vu36(vu34, 0, 3, vu40)
                    vu35(vu34, 0, 32, v49)
                    vu35(vu34, 0, 26, 6)
                    vu35(vu34, 0, 3, 6)
                    vu41(vu10.cast("void*", v50))
                    vu35(vu34, 0, 32, vu37[0])
                    vu35(vu34, 0, 26, vu38[0])
                    vu35(vu34, 0, 3, vu40[0])
                end
            end
        end
    end
end
local vu51 = {
    [207] = {
        recv = {
            {
                "leftRightKeys",
                "int16",
                true
            },
            {
                "upDownKeys",
                "int16",
                true
            },
            {
                "keysData",
                "int16",
                false
            },
            {
                "position",
                "vector3d",
                false
            },
            {
                "quaternion",
                "normQuat",
                false
            },
            {
                "health/armor",
                "decompressHealthAndArmor",
                false
            },
            {
                "weapon",
                "int8",
                false
            },
            {
                "specialAction",
                "int8",
                false
            },
            {
                "moveSpeed",
                "compressedVector",
                false
            },
            {
                {
                    "surfingVehicleId",
                    "surfingOffsets"
                },
                {
                    "int16",
                    "vector3d"
                },
                true
            },
            {
                {
                    "animationId",
                    "animationFlags"
                },
                {
                    "int16",
                    "int16"
                },
                true
            }
        },
        send = {
            {
                "leftRightKeys",
                "int16",
                false
            },
            {
                "upDownKeys",
                "int16",
                false
            },
            {
                "keysData",
                "int16",
                false
            },
            {
                "position",
                "vector3d",
                false
            },
            {
                "quaternion",
                "floatQuat",
                false
            },
            {
                "health",
                "int8",
                false
            },
            {
                "armor",
                "int8",
                false
            },
            {
                "weapon",
                "int8",
                false
            },
            {
                "specialAction",
                "int8",
                false
            },
            {
                "moveSpeed",
                "vector3d",
                false
            },
            {
                "surfingOffsets",
                "vector3d",
                false
            },
            {
                "surfingVehicleId",
                "int16",
                false
            },
            {
                "animationId",
                "int16",
                false
            },
            {
                "animationFlags",
                "int16",
                false
            }
        }
    },
    [200] = {
        recv = {
            {
                "vehicleId",
                "int16",
                false
            },
            {
                "leftRightKeys",
                "int16",
                false
            },
            {
                "upDownKeys",
                "int16",
                false
            },
            {
                "keysData",
                "int16",
                false
            },
            {
                "quaternion",
                "normQuat",
                false
            },
            {
                "position",
                "vector3d",
                false
            },
            {
                "moveSpeed",
                "compressedVector",
                false
            },
            {
                "vehicleHealth",
                "int16",
                false
            },
            {
                "playerHealth/armor",
                "decompressHealthAndArmor",
                false
            },
            {
                "weapon",
                "int8",
                false
            },
            {
                "siren",
                "bool",
                false
            },
            {
                "landingGear",
                "bool",
                false
            },
            {
                "trainSpeed",
                "float",
                true
            },
            {
                "trailerId",
                "int16",
                true
            }
        },
        send = {
            {
                "vehicleId",
                "int16",
                false
            },
            {
                "leftRightKeys",
                "int16",
                false
            },
            {
                "upDownKeys",
                "int16",
                false
            },
            {
                "keysData",
                "int16",
                false
            },
            {
                "quaternion",
                "floatQuat",
                false
            },
            {
                "position",
                "vector3d",
                false
            },
            {
                "moveSpeed",
                "vector3d",
                false
            },
            {
                "vehicleHealth",
                "float",
                false
            },
            {
                "playerHealth",
                "int8",
                false
            },
            {
                "armor",
                "int8",
                false
            },
            {
                "weapon",
                "int8",
                false
            },
            {
                "siren",
                "int8",
                false
            },
            {
                "landingGearState",
                "int8",
                false
            },
            {
                "trailerId",
                "int16",
                false
            },
            {
                "trainSpeed",
                "float",
                false
            }
        }
    },
    [211] = {
        {
            "vehicleId",
            "int16",
            false
        },
        {
            "seatId",
            "int8",
            false
        },
        {
            "weapon",
            "int8",
            false
        },
        {
            "health",
            "int8",
            false
        },
        {
            "armor",
            "int8",
            false
        },
        {
            "leftRightKeys",
            "int16",
            false
        },
        {
            "upDownKeys",
            "int16",
            false
        },
        {
            "keysData",
            "int16",
            false
        },
        {
            "position",
            "vector3d",
            false
        }
    },
    [210] = {
        {
            "trailerId",
            "int16",
            false
        },
        {
            "position",
            "vector3d",
            false
        },
        {
            "roll",
            "vector3d",
            false
        },
        {
            "direction",
            "vector3d",
            false
        },
        {
            "speed",
            "vector3d",
            false
        },
        {
            "unk",
            "int32",
            false
        }
    },
    [209] = {
        {
            "vehicleId",
            "int16",
            false
        },
        {
            "seatId",
            "int8",
            false
        },
        {
            "roll",
            "vector3d",
            false
        },
        {
            "direction",
            "vector3d",
            false
        },
        {
            "position",
            "vector3d",
            false
        },
        {
            "moveSpeed",
            "vector3d",
            false
        },
        {
            "turnSpeed",
            "vector3d",
            false
        },
        {
            "vehicleHealth",
            "float",
            false
        }
    },
    [203] = {
        {
            "camMode",
            "int8",
            false
        },
        {
            "camFront",
            "vector3d",
            false
        },
        {
            "camPos",
            "vector3d",
            false
        },
        {
            "aimZ",
            "float",
            false
        },
        {
            "camExtZoom",
            "int8",
            false
        },
        {
            "weaponState",
            "int8",
            false
        },
        {
            "unk",
            "int8",
            false
        }
    },
    [206] = {
        {
            "targetType",
            "int8",
            false
        },
        {
            "targetId",
            "int16",
            false
        },
        {
            "origin",
            "vector3d",
            false
        },
        {
            "target",
            "vector3d",
            false
        },
        {
            "center",
            "vector3d",
            false
        },
        {
            "weapon",
            "int8",
            false
        }
    }
}
local vu52 = {
    outcoming = {},
    incoming = {}
}
vu52.outcoming[26] = {
    {
        "vehicleId",
        "int16",
        false
    },
    {
        "passenger",
        "bool8",
        false
    }
}
vu52.outcoming[23] = {
    {
        "playerId",
        "int16",
        false
    },
    {
        "source",
        "int8",
        false
    }
}
vu52.outcoming[25] = {
    {
        "version",
        "int32",
        false
    },
    {
        "mod",
        "int8",
        false
    },
    {
        "nickname",
        "string8",
        false
    },
    {
        "challengeResponse",
        "int32",
        false
    },
    {
        "joinAuthKey",
        "int8",
        false
    },
    {
        "clientVer",
        "string8",
        false
    },
    {
        "unk",
        "int32",
        false
    }
}
vu52.outcoming[27] = {
    {
        "type",
        "int32",
        false
    },
    {
        "objectId",
        "int16",
        false
    },
    {
        "model",
        "int32",
        false
    },
    {
        "position",
        "vector3d",
        false
    }
}
vu52.outcoming[50] = {
    {
        "command",
        "string32",
        false
    }
}
vu52.outcoming[52] = {}
vu52.outcoming[53] = {
    {
        "reason",
        "int8",
        false
    },
    {
        "killerId",
        "int16",
        false
    }
}
vu52.outcoming[62] = {
    {
        "dialogId",
        "int16",
        false
    },
    {
        "button",
        "int8",
        false
    },
    {
        "listBoxId",
        "int16",
        false
    },
    {
        "input",
        "string8",
        false
    }
}
vu52.outcoming[83] = {
    {
        "textDrawId",
        "int16",
        false
    }
}
vu52.outcoming[96] = {
    {
        "vehicleId",
        "int32",
        false
    },
    {
        "param1",
        "int32",
        false
    },
    {
        "param2",
        "int32",
        false
    },
    {
        "event",
        "int32",
        false
    }
}
vu52.outcoming[101] = {
    {
        "message",
        "string8",
        false
    }
}
vu52.outcoming[103] = {
    {
        "flags",
        "int8",
        false
    },
    {
        "unk1",
        "int32",
        false
    },
    {
        "unk2",
        "int8",
        false
    }
}
vu52.outcoming[106] = {
    {
        "vehicleId",
        "int16",
        false
    },
    {
        "panelDmg",
        "int32",
        false
    },
    {
        "doorDmg",
        "int32",
        false
    },
    {
        "lights",
        "int8",
        false
    },
    {
        "tires",
        "int8",
        false
    }
}
vu52.outcoming[116] = {
    {
        "response",
        "int32",
        false
    },
    {
        "index",
        "int32",
        false
    },
    {
        "model",
        "int32",
        false
    },
    {
        "bone",
        "int32",
        false
    },
    {
        "position",
        "vector3d",
        false
    },
    {
        "rotation",
        "vector3d",
        false
    },
    {
        "scale",
        "vector3d",
        false
    },
    {
        "color1",
        "int32",
        false
    },
    {
        "color2",
        "int32",
        false
    }
}
vu52.outcoming[117] = {
    {
        "playerObject",
        "bool",
        false
    },
    {
        "objectId",
        "int16",
        false
    },
    {
        "response",
        "int32",
        false
    },
    {
        "position",
        "vector3d",
        false
    },
    {
        "rotation",
        "vector3d",
        false
    }
}
vu52.outcoming[118] = {
    {
        "interior",
        "int8",
        false
    }
}
vu52.outcoming[119] = {
    {
        "position",
        "vector3d",
        false
    }
}
vu52.outcoming[128] = {
    {
        "classId",
        "int32",
        false
    }
}
vu52.outcoming[129] = {}
vu52.outcoming[131] = {
    {
        "pickupId",
        "int32",
        false
    }
}
vu52.outcoming[132] = {
    {
        "row",
        "int8",
        false
    }
}
vu52.outcoming[136] = {
    {
        "vehicleId",
        "int16",
        false
    }
}
vu52.outcoming[140] = {}
vu52.outcoming[154] = {
    {
        "vehicleId",
        "int16",
        false
    }
}
vu52.outcoming[155] = {}
vu52.outcoming[115] = {
    {
        "take",
        "bool",
        false
    },
    {
        "playerId",
        "int16",
        false
    },
    {
        "damage",
        "float",
        false
    },
    {
        "weapon",
        "int32",
        false
    },
    {
        "bodyPart",
        "int32",
        false
    }
}
vu52.incoming[139] = {
    {
        "zoneNames",
        "bool",
        false
    },
    {
        "useCJWalk",
        "bool",
        false
    },
    {
        "allowWeapons",
        "bool",
        false
    },
    {
        "limitGlobalChatRadius",
        "bool",
        false
    },
    {
        "globalChatRadius",
        "float",
        false
    },
    {
        "nametagDrawDist",
        "float",
        false
    },
    {
        "disableEnterExits",
        "bool",
        false
    },
    {
        "nametagLOS",
        "bool",
        false
    },
    {
        "tirePopping",
        "bool",
        false
    },
    {
        "classesAvailable",
        "int32",
        false
    },
    {
        "playerId",
        "int16",
        false
    },
    {
        "showPlayerTags",
        "bool",
        false
    },
    {
        "playerMarkersMode",
        "int32",
        false
    },
    {
        "worldTime",
        "int8",
        false
    },
    {
        "worldWeather",
        "int8",
        false
    },
    {
        "gravity",
        "float",
        false
    },
    {
        "lanMode",
        "bool",
        false
    },
    {
        "deathMoneyDrop",
        "int32",
        false
    },
    {
        "instagib",
        "bool",
        false
    },
    {
        "normalOnfootSendrate",
        "int32",
        false
    },
    {
        "normalIncarSendrate",
        "int32",
        false
    },
    {
        "normalFiringSendrate",
        "int32",
        false
    },
    {
        "sendMultiplier",
        "int32",
        false
    },
    {
        "lagCompMode",
        "int32",
        false
    },
    {
        "hostname",
        "string8",
        false
    },
    {
        "vehicleModels",
        "GameVehicleModels",
        false
    },
    {
        "unknown",
        "int32",
        false
    }
}
vu52.incoming[137] = {
    {
        "playerId",
        "int16",
        false
    },
    {
        "color",
        "int32",
        false
    },
    {
        "isNPC",
        "bool8",
        false
    },
    {
        "nickname",
        "string8",
        false
    }
}
vu52.incoming[138] = {
    {
        "playerId",
        "int16",
        false
    },
    {
        "reason",
        "int8",
        false
    }
}
vu52.incoming[128] = {
    {
        "canSpawn",
        "bool8",
        false
    },
    {
        "team",
        "int8",
        false
    },
    {
        "skin",
        "int32",
        false
    },
    {
        "unk",
        "int8",
        false
    },
    {
        "position",
        "vector3d",
        false
    },
    {
        "rotation",
        "float",
        false
    },
    {
        "weapons",
        "Int32Array3",
        false
    },
    {
        "ammo",
        "Int32Array3",
        false
    }
}
vu52.incoming[129] = {
    {
        "response",
        "bool8",
        false
    }
}
vu52.incoming[11] = {
    {
        "playerId",
        "int16",
        false
    },
    {
        "nickname",
        "string8",
        false
    },
    {
        "success",
        "bool8",
        false
    }
}
vu52.incoming[12] = {
    {
        "position",
        "vector3d",
        false
    }
}
vu52.incoming[13] = {
    {
        "position",
        "vector3d",
        false
    }
}
vu52.incoming[14] = {
    {
        "health",
        "float",
        false
    }
}
vu52.incoming[15] = {
    {
        "controllable",
        "bool8",
        false
    }
}
vu52.incoming[16] = {
    {
        "soundId",
        "int32",
        false
    },
    {
        "position",
        "vector3d",
        false
    }
}
vu52.incoming[17] = {
    {
        "maxX",
        "float",
        false
    },
    {
        "minX",
        "float",
        false
    },
    {
        "maxY",
        "float",
        false
    },
    {
        "minY",
        "float",
        false
    }
}
vu52.incoming[18] = {
    {
        "money",
        "int32",
        false
    }
}
vu52.incoming[19] = {
    {
        "angle",
        "float",
        false
    }
}
vu52.incoming[20] = {}
vu52.incoming[21] = {}
vu52.incoming[22] = {
    {
        "weaponId",
        "int32",
        false
    },
    {
        "ammo",
        "int32",
        false
    }
}
vu52.incoming[28] = {}
vu52.incoming[29] = {
    {
        "hour",
        "int8",
        false
    },
    {
        "minute",
        "int8",
        false
    }
}
vu52.incoming[30] = {
    {
        "state",
        "bool8",
        false
    }
}
vu52.incoming[32] = {
    {
        "playerId",
        "int16",
        false
    },
    {
        "team",
        "int8",
        false
    },
    {
        "model",
        "int32",
        false
    },
    {
        "positon",
        "vector3d",
        false
    },
    {
        "rotation",
        "float",
        false
    },
    {
        "color",
        "int32",
        false
    },
    {
        "fightingStyle",
        "int8",
        false
    }
}
vu52.incoming[33] = {
    {
        "name",
        "string256",
        false
    }
}
vu52.incoming[34] = {
    {
        "playerId",
        "int16",
        false
    },
    {
        "skill",
        "int32",
        false
    },
    {
        "level",
        "int16",
        false
    }
}
vu52.incoming[35] = {
    {
        "drunkLevel",
        "int32",
        false
    }
}
vu52.incoming[36] = {
    {
        "id",
        "int16",
        false
    },
    {
        "color",
        "int32",
        false
    },
    {
        "position",
        "vector3d",
        false
    },
    {
        "distance",
        "float",
        false
    },
    {
        "testLOS",
        "bool8",
        false
    },
    {
        "attachedPlayerId",
        "int16",
        false
    },
    {
        "attachedVehicleId",
        "int16",
        false
    },
    {
        "text",
        "encodedString4096",
        false
    }
}
vu52.incoming[37] = {}
vu52.incoming[38] = {
    {
        "type",
        "int8",
        false
    },
    {
        "position",
        "vector3d",
        false
    },
    {
        "nextPosition",
        "vector3d",
        false
    },
    {
        "size",
        "float",
        false
    }
}
vu52.incoming[39] = {}
vu52.incoming[40] = {}
vu52.incoming[41] = {
    {
        "url",
        "string8",
        false
    },
    {
        "position",
        "vector3d",
        false
    },
    {
        "radius",
        "float",
        false
    },
    {
        "usePosition",
        "bool8",
        false
    }
}
vu52.incoming[42] = {}
vu52.incoming[43] = {
    {
        "modelId",
        "int32",
        false
    },
    {
        "position",
        "vector3d",
        false
    },
    {
        "radius",
        "float",
        false
    }
}
vu52.incoming[44] = {
    {
        "objectId",
        "int16",
        false
    },
    {
        "model",
        "int32",
        false
    },
    {
        "position",
        "vector3d",
        false
    },
    {
        "rotation",
        "vector3d",
        false
    },
    {
        "drawDistance",
        "float",
        false
    },
    {
        "noCameraCol",
        "bool8",
        false
    },
    {
        "attachData",
        "objectAttachData",
        false
    },
    {
        "texturesCount",
        "int8",
        false
    },
    {
        "materialData",
        "objectMaterialData",
        false
    }
}
vu52.incoming[45] = {
    {
        "objectId",
        "int16",
        false
    },
    {
        "position",
        "vector3d",
        false
    }
}
vu52.incoming[46] = {
    {
        "objectId",
        "int16",
        false
    },
    {
        "rotation",
        "vector3d",
        false
    }
}
vu52.incoming[47] = {
    {
        "objectId",
        "int16",
        false
    }
}
vu52.incoming[55] = {
    {
        "killerId",
        "int16",
        false
    },
    {
        "victimId",
        "int16",
        false
    },
    {
        "weapon",
        "int8",
        false
    }
}
vu52.incoming[56] = {
    {
        "iconId",
        "int8",
        false
    },
    {
        "position",
        "vector3d",
        false
    },
    {
        "type",
        "int8",
        false
    },
    {
        "color",
        "int32",
        false
    },
    {
        "style",
        "int8",
        false
    }
}
vu52.incoming[57] = {
    {
        "vehicleId",
        "int16",
        false
    },
    {
        "componentId",
        "int16",
        false
    }
}
vu52.incoming[58] = {
    {
        "textLabelId",
        "int16",
        false
    }
}
vu52.incoming[59] = {
    {
        "playerId",
        "int16",
        false
    },
    {
        "color",
        "int32",
        false
    },
    {
        "distance",
        "float",
        false
    },
    {
        "duration",
        "int32",
        false
    },
    {
        "message",
        "string8",
        false
    }
}
vu52.incoming[60] = {
    {
        "time",
        "int32",
        false
    }
}
vu52.incoming[61] = {
    {
        "dialogId",
        "int16",
        false
    },
    {
        "style",
        "int8",
        false
    },
    {
        "title",
        "string8",
        false
    },
    {
        "button1",
        "string8",
        false
    },
    {
        "button2",
        "string8",
        false
    },
    {
        "text",
        "encodedString4096",
        false
    }
}
vu52.incoming[63] = {
    {
        "id",
        "int32",
        false
    }
}
vu52.incoming[65] = {
    {
        "vehicleId",
        "int16",
        false
    },
    {
        "interiorId",
        "int8",
        false
    }
}
vu52.incoming[66] = {
    {
        "armour",
        "float",
        false
    }
}
vu52.incoming[67] = {
    {
        "weaponId",
        "int32",
        false
    }
}
vu52.incoming[68] = {
    {
        "team",
        "int8",
        false
    },
    {
        "skin",
        "int32",
        false
    },
    {
        "unk",
        "int8",
        false
    },
    {
        "position",
        "vector3d",
        false
    },
    {
        "rotation",
        "float",
        false
    },
    {
        "weapons",
        "Int32Array3",
        false
    },
    {
        "ammo",
        "Int32Array3",
        false
    }
}
vu52.incoming[69] = {
    {
        "playerId",
        "int16",
        false
    },
    {
        "teamId",
        "int8",
        false
    }
}
vu52.incoming[70] = {
    {
        "vehicleId",
        "int16",
        false
    },
    {
        "seatId",
        "int8",
        false
    }
}
vu52.incoming[71] = {}
vu52.incoming[72] = {
    {
        "playerId",
        "int16",
        false
    },
    {
        "color",
        "int32",
        false
    }
}
vu52.incoming[73] = {
    {
        "style",
        "int32",
        false
    },
    {
        "time",
        "int32",
        false
    },
    {
        "text",
        "string32",
        false
    }
}
vu52.incoming[74] = {}
vu52.incoming[75] = {
    {
        "objectId",
        "int16",
        false
    },
    {
        "playerId",
        "int16",
        false
    },
    {
        "offsets",
        "vector3d",
        false
    },
    {
        "rotation",
        "vector3d",
        false
    }
}
vu52.incoming[76] = {
    {
        "menuId",
        "int8",
        false
    },
    {
        "twoColumns",
        "bool32",
        false
    },
    {
        "menuTitle",
        "string256",
        false
    },
    {
        "X/Y",
        "vector2d",
        false
    },
    {
        "colWidth",
        "vector2d",
        false
    },
    {
        "menu",
        "int32",
        false
    }
}
vu52.incoming[77] = {
    {
        "menuId",
        "int8",
        false
    }
}
vu52.incoming[78] = {
    {
        "menuId",
        "int8",
        false
    }
}
vu52.incoming[79] = {
    {
        "position",
        "vector3d",
        false
    },
    {
        "style",
        "int32",
        false
    },
    {
        "radius",
        "float",
        false
    }
}
vu52.incoming[80] = {
    {
        "playerId",
        "int16",
        false
    },
    {
        "show",
        "bool8",
        false
    }
}
vu52.incoming[81] = {
    {
        "objectId",
        "int16",
        false
    }
}
vu52.incoming[82] = {
    {
        "setPos",
        "bool",
        false
    },
    {
        "fromPos",
        "vector3d",
        false
    },
    {
        "destPos",
        "vector3d",
        false
    },
    {
        "time",
        "int32",
        false
    },
    {
        "mode",
        "int8",
        false
    }
}
vu52.incoming[85] = {
    {
        "zone",
        "int16",
        false
    }
}
vu52.incoming[86] = {
    {
        "playerId",
        "int16",
        false
    },
    {
        "animLib",
        "string8",
        false
    },
    {
        "animName",
        "string8",
        false
    },
    {
        "loop",
        "bool",
        false
    },
    {
        "lockX",
        "bool",
        false
    },
    {
        "lockY",
        "bool",
        false
    },
    {
        "freeze",
        "bool",
        false
    },
    {
        "time",
        "int32",
        false
    }
}
vu52.incoming[87] = {
    {
        "playerId",
        "int16",
        false
    }
}
vu52.incoming[88] = {
    {
        "actionId",
        "int8",
        false
    }
}
vu52.incoming[89] = {
    {
        "playerId",
        "int16",
        false
    },
    {
        "styleId",
        "int8",
        false
    }
}
vu52.incoming[90] = {
    {
        "velocity",
        "vector3d",
        false
    }
}
vu52.incoming[91] = {
    {
        "turn",
        "bool8",
        false
    },
    {
        "velocity",
        "vector3d",
        false
    }
}
vu52.incoming[93] = {
    {
        "color",
        "int32",
        false
    },
    {
        "message",
        "string32",
        false
    }
}
vu52.incoming[94] = {
    {
        "hour",
        "int8",
        false
    }
}
vu52.incoming[95] = {
    {
        "id",
        "int32",
        false
    },
    {
        "model",
        "int32",
        false
    },
    {
        "pickupType",
        "int32",
        false
    },
    {
        "position",
        "vector3d",
        false
    }
}
vu52.incoming[99] = {
    {
        "objectId",
        "int16",
        false
    },
    {
        "fromPos",
        "vector3d",
        false
    },
    {
        "destPos",
        "vector3d",
        false
    },
    {
        "speed",
        "float",
        false
    },
    {
        "rotation",
        "vector3d",
        false
    }
}
vu52.incoming[104] = {
    {
        "state",
        "bool",
        false
    }
}
vu52.incoming[105] = {
    {
        "id",
        "int16",
        false
    },
    {
        "text",
        "string16",
        false
    }
}
vu52.incoming[107] = {
    {
        "position",
        "vector3d",
        false
    },
    {
        "radius",
        "float",
        false
    }
}
vu52.incoming[108] = {
    {
        "zoneId",
        "int16",
        false
    },
    {
        "squareStart",
        "vector2d",
        false
    },
    {
        "squareEnd",
        "vector2d",
        false
    },
    {
        "color",
        "int32",
        false
    }
}
vu52.incoming[112] = {
    {
        "suspectId",
        "int16",
        false
    },
    {
        "unk",
        "Int32Array3",
        false
    },
    {
        "crime",
        "int32",
        false
    },
    {
        "coordinates",
        "vector3d",
        false
    }
}
vu52.incoming[120] = {
    {
        "zoneId",
        "int16",
        false
    }
}
vu52.incoming[121] = {
    {
        "zoneId",
        "int16",
        false
    },
    {
        "color",
        "int32",
        false
    }
}
vu52.incoming[122] = {
    {
        "objectId",
        "int16"
    }
}
vu52.incoming[123] = {
    {
        "vehicleId",
        "int16",
        false
    },
    {
        "text",
        "string8",
        false
    }
}
vu52.incoming[124] = {
    {
        "state",
        "bool32",
        false
    }
}
vu52.incoming[126] = {
    {
        "playerId",
        "int16",
        false
    },
    {
        "camType",
        "int8",
        false
    }
}
vu52.incoming[127] = {
    {
        "vehicleId",
        "int16",
        false
    },
    {
        "camType",
        "int8",
        false
    }
}
vu52.incoming[134] = {
    {
        "textDrawId",
        "int16",
        false
    },
    {
        "flags",
        "int8",
        false
    },
    {
        "letterWidth",
        "float",
        false
    },
    {
        "letterHeight",
        "float",
        false
    },
    {
        "letterColor",
        "int32",
        false
    },
    {
        "lineWidth",
        "float",
        false
    },
    {
        "lineHeight",
        "float",
        false
    },
    {
        "boxColor",
        "int32",
        false
    },
    {
        "shadow",
        "int8",
        false
    },
    {
        "outline",
        "int8",
        false
    },
    {
        "bgColor",
        "int32",
        false
    },
    {
        "style",
        "int8",
        false
    },
    {
        "selectable",
        "int8",
        false
    },
    {
        "position",
        "vector2d",
        false
    },
    {
        "modelId",
        "int16",
        false
    },
    {
        "rotation",
        "vector3d",
        false
    },
    {
        "zoom",
        "float",
        false
    },
    {
        "color",
        "int32",
        false
    },
    {
        "text",
        "string16",
        false
    }
}
vu52.incoming[133] = {
    {
        "wantedLevel",
        "int8",
        false
    }
}
vu52.incoming[135] = {
    {
        "textDrawId",
        "int16",
        false
    }
}
vu52.incoming[144] = {
    {
        "iconId",
        "int8",
        false
    }
}
vu52.incoming[145] = {
    {
        "weaponId",
        "int8",
        false
    },
    {
        "ammo",
        "int16",
        false
    }
}
vu52.incoming[146] = {
    {
        "gravity",
        "float",
        false
    }
}
vu52.incoming[147] = {
    {
        "vehicleId",
        "int16",
        false
    },
    {
        "health",
        "float",
        false
    }
}
vu52.incoming[148] = {
    {
        "trailerId",
        "int16",
        false
    },
    {
        "vehicleId",
        "int16",
        false
    }
}
vu52.incoming[149] = {
    {
        "vehicleId",
        "int16",
        false
    }
}
vu52.incoming[152] = {
    {
        "weatherId",
        "int8",
        false
    }
}
vu52.incoming[153] = {
    {
        "playerId",
        "int16",
        false
    },
    {
        "skinId",
        "int32",
        false
    }
}
vu52.incoming[156] = {
    {
        "interior",
        "int8",
        false
    }
}
vu52.incoming[157] = {
    {
        "camPos",
        "vector3d",
        false
    }
}
vu52.incoming[158] = {
    {
        "lookAtPos",
        "vector3d",
        false
    },
    {
        "cutType",
        "int8",
        false
    }
}
vu52.incoming[159] = {
    {
        "vehicleId",
        "int16",
        false
    },
    {
        "position",
        "vector3d",
        false
    }
}
vu52.incoming[160] = {
    {
        "vehicleId",
        "int16",
        false
    },
    {
        "angle",
        "float",
        false
    }
}
vu52.incoming[161] = {
    {
        "vehicleId",
        "int16",
        false
    },
    {
        "objective",
        "bool8",
        false
    },
    {
        "doorsLocked",
        "bool8",
        false
    }
}
vu52.incoming[162] = {}
vu52.incoming[101] = {
    {
        "playerId",
        "int16",
        false
    },
    {
        "text",
        "string8",
        false
    }
}
vu52.incoming[130] = {
    {
        "reason",
        "int8",
        false
    }
}
vu52.incoming[163] = {
    {
        "playerId",
        "int16",
        false
    }
}
vu52.incoming[164] = {
    {
        "vehicleId",
        "int16",
        false
    },
    {
        "type",
        "int32",
        false
    },
    {
        "position",
        "vector3d",
        false
    },
    {
        "rotation",
        "float",
        false
    },
    {
        "interiorColor1",
        "int8",
        false
    },
    {
        "interiorColor2",
        "int8",
        false
    },
    {
        "health",
        "float",
        false
    },
    {
        "interiorId",
        "int8",
        false
    },
    {
        "doorDamageStatus",
        "int32",
        false
    },
    {
        "panelDamageStatus",
        "int32",
        false
    },
    {
        "lightDamageStatus",
        "int8",
        false
    },
    {
        "addSiren",
        "int8",
        false
    },
    {
        "modSlots",
        "vehicleModSlots",
        false
    },
    {
        "paintJob",
        "int8",
        false
    },
    {
        "bodyColor1",
        "int32",
        false
    },
    {
        "bodyColor2",
        "int32",
        false
    },
    {
        "unk",
        "int8",
        false
    }
}
vu52.incoming[165] = {
    {
        "vehicleId",
        "int16",
        false
    }
}
vu52.incoming[166] = {
    {
        "playerId",
        "int16",
        false
    }
}
vu52.incoming[26] = {
    {
        "playerId",
        "int16",
        false
    },
    {
        "vehicleId",
        "int16",
        false
    },
    {
        "passenger",
        "bool8",
        false
    }
}
vu52.incoming[155] = {}
vu52.incoming[84] = {
    {
        "objectId",
        "int16",
        false
    },
    {
        "materialData",
        "objectMaterialDataSet",
        false
    }
}
vu52.incoming[171] = {
    {
        "actorId",
        "int16",
        false
    },
    {
        "skinId",
        "int32",
        false
    },
    {
        "position",
        "vector3d",
        false
    },
    {
        "rotation",
        "float",
        false
    },
    {
        "health",
        "float",
        false
    }
}
vu52.incoming[83] = {
    {
        "state",
        "bool",
        false
    },
    {
        "hovercolor",
        "int32",
        false
    }
}
vu52.incoming[24] = {
    {
        "vehicleId",
        "int16",
        false
    },
    {
        "engine",
        "int8",
        false
    },
    {
        "lights",
        "int8",
        false
    },
    {
        "alarm",
        "int8",
        false
    },
    {
        "doors",
        "int8",
        false
    },
    {
        "bonnet",
        "int8",
        false
    },
    {
        "boot",
        "int8",
        false
    },
    {
        "objective",
        "int8",
        false
    },
    {
        "unk",
        "int8",
        false
    },
    {
        "driver",
        "int8",
        false
    },
    {
        "passenger",
        "int8",
        false
    },
    {
        "backleft",
        "int8",
        false
    },
    {
        "backright",
        "int8",
        false
    },
    {
        "windows_driver",
        "int8",
        false
    },
    {
        "windows_passenger",
        "int8",
        false
    },
    {
        "windows_backleft",
        "int8",
        false
    },
    {
        "windows_backright",
        "int8",
        false
    }
}
vu52.incoming[113] = {
    {
        "playerId",
        "int16",
        false
    },
    {
        "index",
        "int32",
        false
    },
    {
        "create",
        "bool",
        false
    },
    {
        "modelId",
        "int32",
        false
    },
    {
        "bone",
        "int32",
        false
    },
    {
        "offset",
        "vector3d",
        false
    },
    {
        "rotation",
        "vector3d",
        false
    },
    {
        "scale",
        "vector3d",
        false
    },
    {
        "color1",
        "int32",
        false
    },
    {
        "color2",
        "int32",
        false
    }
}
local vu53 = {}
local vu54 = {}
local vu55 = {}
local vu56 = {}
function check_has_in_filter(p57, p58)
    local v59, v60, v61 = pairs(p58)
    while true do
        local v62
        v61, v62 = v59(v60, v61)
        if v61 == nil then
            break
        end
        if v62[1]:gsub("##.+", "") == p57 then
            return v62[2].v
        end
    end
end
function render_nops_filter(p63, p64, p65)
    if script.nops_page == p63 then
        local v66, v67, v68 = pairs(p64)
        while true do
            local v69
            v68, v69 = v66(v67, v68)
            if v68 == nil then
                break
            end
            if # p65.v <= 0 then
                vu2.Checkbox(v69[1], v69[2])
            elseif string.find(string.lower(v69[1]), string.lower(p65.v), 1, true) then
                vu2.Checkbox(v69[1], v69[2])
            end
        end
    end
end
function ReadNopsData()
    for v70 = 200, 212 do
        if raknetGetPacketName(v70) ~= nil then
            if vu51[v70] ~= nil then
                vu53[v70] = {
                    raknetGetPacketName(v70),
                    vu2.ImBool(false)
                }
                vu54[v70] = {
                    raknetGetPacketName(v70) .. "##1",
                    vu2.ImBool(false)
                }
            end
        end
    end
    for v71 = 1, 166 do
        if raknetGetRpcName(v71) ~= nil then
            if vu52.incoming[v71] ~= nil then
                vu55[v71] = {
                    raknetGetRpcName(v71),
                    vu2.ImBool(false)
                }
            end
            if vu52.outcoming[v71] ~= nil then
                vu56[v71] = {
                    raknetGetRpcName(v71) .. "##1",
                    vu2.ImBool(false)
                }
            end
        end
    end
end
ReadNopsData()
effil = require("effil")
function asyncHttpRequest(p72, p73, p74, p75, p76)
    local vu83 = effil.thread(function(p77, p78, p79)
        local v80 = require("requests")
        local v81, v82 = pcall(v80.request, p77, p78, p79)
        if not v81 then
            return false, v82
        end
        v82.xml = nil
        v82.json = nil
        return true, v82
    end)(p72, p73, p74)
    local vu84 = p75 or function()
    end
    local vu85 = p76 or function()
    end
    lua_thread.create(function()
        local v86 = vu83
        while true do
            local v87, v88 = v86:status()
            if v88 then
                break
            end
            if v87 == "completed" then
                local v89, v90 = v86:get()
                if v89 then
                    vu84(v90)
                else
                    vu85(v90)
                end
                return
            end
            if v87 == "canceled" then
                return vu85(v87)
            end
            wait(0)
        end
        return vu85(err)
    end)
end
version_status = "uptodate"
function SendRequests()
    if not ADMIN_MODE then
        CleanChat()
    end
    sampAddChatMessage("{b700d4}[MENU DOS CRIA]: {B9C9BF}SAMP 0.3.7 {ffffff}Started", 11993300)
    sampAddChatMessage("{b700d4}[MENU DOS CRIA]: {B9C9BF}Loaded successfully!", 11993300)
    version_status = "uptodate"
end
function getSAMPMasterList()
    local vu91 = {}
    asyncHttpRequest("GET", "http://lists.sa-mp.com/0.3.7/internet", nil, function(p92)
        if p92.text ~= nil then
            local v93, v94, v95 = string.gmatch(p92.text, "([^\n\r]+)")
            while true do
                v95 = v93(v94, v95)
                if v95 == nil then
                    break
                end
                table.insert(vu91, v95)
            end
        end
    end)
    return vu91
end
inicfg = require("inicfg")
objectfinder_table_inputs = {
    {
        1550,
        ""
    },
    {
        19941,
        ""
    },
    {
        11745,
        ""
    },
    {
        2919,
        ""
    },
    {
        1276,
        ""
    },
    {
        19320,
        ""
    },
    {
        19473,
        ""
    }
}
GUI = GUI or {}
GUI.player_input = imgui.ImBuffer(10)
GUI.carro = imgui.ImBuffer(10)
GUI.vehicle_id = imgui.ImBuffer(10)
GUI.playerinfoo = imgui.ImBuffer(10)
ObjectFinder_Table = {}
MainSettingsdirectIni = "MENU DOS CRIA\\MENU DOS CRIA_SETTINGS.ini"
ObjectFinderDirectIni = "MENU DOS CRIA\\MENU DOS CRIA_OBJ"
local v96 = {
    license = {
        Agree = true
    },
    WATER_RPG = {
        r = 1,
        g = 1,
        b = 1,
        a = 1
    },
    functions = {
GM = false,
NoFall = false,
autorun = false,
InfinityRun = false,
MegaJump = false,
AntiStun = false,
AntiAfk = false,
InfO2 = false,
Chams = false,
Fugga = false,
Invisible = false,
InvertPlayer2021 = false,
CrazyPlayer2021 = false,
FastWalk = false,
FastRotation = false,
AirBreak = false,
InfinityAmmo = false,
FullSkills = false,
NoReload = false,
bell = false,
Cbug = false,
NoSpread = false,
SensFix = false,
AimBot = false,
aimbotproSkipDead = false,
aimbotdisabledOnAnim = false,
aimbotdisabledIfFriend = false,
aimbotdisabledOnAFk = false,
aimbotskipDead = false,
aimbotteam_ignore = false,
aimbotsafeZone = 1,
aimbotjobRadius = 80,
aimbotsmoothSpeed = 5,
aimbotaddSmoothSpeed = 1,
SilentAim = false,
noCamRestore = false,
Rapid = false,
gtavaim = false,
GMCar = false,
GMWheels = false,
Fbike = false,
FC = false,
Tmode = false,
InfinityFuel = false,
NoRadio = false,
Water = false,
CarShot = false,
CarJump = false,
driftInCar = false,
bmx = false,
Nitro = false,
altspeed = false,
dirigirsemlicenca = false,
destrancar = false,
bloquearrpc = false,
AntiCamPos = false,
AntiAnimClear = false,
AntiFreeze = false,
AntiDialog = false,
InvertVeh2021 = false,
CrazyVeh2021 = false,
rifadobuzeira = false,
grudarexplodir = false,
telagem = false,
pararjogadores = false,
NameTags = false,
SkeletalWallHack = false,
ESPVEICULOS = false,
DisableUnderWaterEffects = false,
DisableWater = false,
SUN = true,
blur = false,
fpsboost = false,
fixwater = true,
fmoney = false,
lmap = false,
MEMORY = false,
CMEM = false,
DrawDist = false,
FogDist = false,
LogDist = false,
Time = false,
Weather = false,
Fovedit = false,
camshake = false,
objectwallhack = false,
objtraser = false,
WaterX = false,
driveUnderWater = false,
rWater = false,
trigger = false,
esplines = false,
espbox = false,
bypass_tp = false,
imgClickInfState = false,
imgSliderInfFov = false,
imgClickInfObj = true,
imgClickInfObj = true,
imgClickInfLine = true,
imgSliderInfBlood = 100,
imgSliderInfRand = 100,
imgClickinfClist = false,
imgClickinfTorso = true,
imgClickinfGroin = false,
imgClickinfHead = false,
fastwalk = 1,
AirBreakSpeed = 2.0,
lengthJump = 0.5,
RapidSpeed = 1,
altspeedhack = 100,
pMemory = 512,
pMemSize = 50,
pDrawEdit = 800,
pFogEdit = 200,
pTime = 1,
pWeather = 1,
pFovedit = 70,
pCamshake = 10,
pLogEdit = 500,
pspam = 0,
volume = 1,
pWaterSpeed = 1,
weapon_ammo = 100,
activekey = 0,
chamstype = 0,
radio_cbug = 0,
aimbot_type = 0,
receive_sound = false,
sms_in_chat = false,
clean_on_sent = false,
ObjectCollision = false,
bypasstpadm = false,
antadm = false,
fakemobile = false,
tutorial = false,
bypassinvi = false,
AirStealth = false,
airbypass = false,
lista = false,
rvanka = false,
RPName = false,
ChecarDroides = false,
SpeedHackBypass = false,
AirVehBypass = false,
speedCap = 50,
OVERHP = false}
}
ini = inicfg.load(inicfg.load(v96, MainSettingsdirectIni))
inicfg.save(ini, MainSettingsdirectIni)
WATER_RPG = vu2.ImFloat4(ini.WATER_RPG.r, ini.WATER_RPG.g, ini.WATER_RPG.b, ini.WATER_RPG.a)
function settings_ini_save()
    local v97 = ini.WATER_RPG
    local v98 = ini.WATER_RPG
    local v99 = ini.WATER_RPG
    local v100 = ini.WATER_RPG
    local v101 = WATER_RPG.v[1]
    local v102 = WATER_RPG.v[2]
    local v103 = WATER_RPG.v[3]
    v100.a = WATER_RPG.v[4]
    v99.b = v103
    v98.g = v102
    v97.r = v101
    ini.functions.GM = GG_GM.v
    ini.functions.NoFall = GG_NoFall.v
    ini.functions.autorun = GG_autorun.v
    ini.functions.InfinityRun = GG_InfinityRun.v
    ini.functions.MegaJump = GG_MegaJump.v
    ini.functions.AntiStun = GG_AntiStun.v
    ini.functions.AntiAfk = GG_AntiAfk.v
    ini.functions.InfO2 = GG_InfO2.v
    ini.functions.Chams = GG_Chams.v
    ini.functions.Fugga = GG_Fugga.v
    ini.functions.Invisible = GG_Invisible.v
    ini.functions.InvertPlayer2021 = GG_InvertPlayer2021.v
    ini.functions.CrazyPlayer2021 = GG_CrazyPlayer2021.v
    ini.functions.AirBreak = GG_AirBreak.v
    ini.functions.FastRotation = GG_FastRotation.v
    ini.functions.InfinityAmmo = GG_InfinityAmmo.v
    ini.functions.FullSkills = GG_FullSkills.v
    ini.functions.NoReload = GG_NoReload.v
    ini.functions.bell = GG_bell.v
    ini.functions.Cbug = GG_Cbug.v
    ini.functions.NoSpread = GG_NoSpread.v
    ini.functions.SensFix = GG_SensFix.v
    ini.functions.AimBot = GG_AimBot.v
    ini.functions.aimbotteam_ignore = aimbot.team_ignore.v
    ini.functions.aimbotskipDead = aimbot.skipDead.v
    ini.functions.aimbotdisabledOnAnim = aimbot.disabledOnAnim.v
    ini.functions.aimbotdisabledIfFriend = aimbot.disabledIfFriend.v
    ini.functions.aimbotdisabledOnAFk = aimbot.disabledOnAFk.v
    ini.functions.aimbotproSkipDead = aimbot.proSkipDead.v
    ini.functions.aimbotsafeZone = aimbot.safeZone.v
    ini.functions.aimbotjobRadius = aimbot.jobRadius.v
    ini.functions.aimbotsmoothSpeed = aimbot.smoothSpeed.v
    ini.functions.aimbotaddSmoothSpeed = aimbot.addSmoothSpeed.v
    ini.functions.SilentAim = GG_SilentAim.v
    ini.functions.noCamRestore = GG_noCamRestore.v
    ini.functions.Rapid = GG_Rapid.v
    ini.functions.gtavaim = GG_gtavaim.v
    ini.functions.GMCar = GG_GMCar.v
    ini.functions.GMWheels = GG_GMWheels.v
    ini.functions.Fbike = GG_Fbike.v
    ini.functions.FC = GG_FC.v
    ini.functions.Tmode = GG_Tmode.v
    ini.functions.InfinityFuel = GG_InfinityFuel.v
    ini.functions.NoRadio = GG_NoRadio.v
    ini.functions.Water = GG_Water.v
    ini.functions.CarShot = GG_CarShot.v
    ini.functions.CarJump = GG_CarJump.v
    ini.functions.driftInCar = GG_driftInCar.v
    ini.functions.bmx = GG_bmx.v
    ini.functions.Nitro = GG_Nitro.v
    ini.functions.altspeed = GG_altspeed.v
    ini.functions.dirigirsemlicenca = GG_dirigirsemlicenca.v
    ini.functions.destrancar = GG_destrancar.v
    ini.functions.bloquearrpc = GG_bloquearrpc.v
    ini.functions.AntiCamPos = GG_AntiCamPos.v
    ini.functions.AntiAnimClear = GG_AntiAnimClear.v
    ini.functions.AntiFreeze = GG_AntiFreeze.v
    ini.functions.AntiDialog = GG_AntiDialog.v
    ini.functions.InvertVeh2021 = GG_InvertVeh2021.v
    ini.functions.CrazyVeh2021 = GG_CrazyVeh2021.v
    ini.functions.rifadobuzeira = GG_rifadobuzeira.v
    ini.functions.grudarexplodir = GG_grudarexplodir.v
    ini.functions.telagem = GG_telagem.v
    ini.functions.pararjogadores = GG_pararjogadores.v
    ini.functions.NameTags = GG_NameTags.v
    ini.functions.SkeletalWallHack = GG_SkeletalWallHack.v
    ini.functions.ESPVEICULOS = GG_ESPVEICULOS.v
    ini.functions.DisableUnderWaterEffects = GG_DisableUnderWaterEffects.v
    ini.functions.DisableWater = GG_DisableWater.v
    ini.functions.SUN = GG_SUN.v
    ini.functions.blur = GG_blur.v
    ini.functions.fpsboost = GG_fpsboost.v
    ini.functions.fixwater = GG_fixwater.v
    ini.functions.fmoney = GG_fmoney.v
    ini.functions.lmap = GG_lmap.v
    ini.functions.MEMORY = GG_MEMORY.v
    ini.functions.CMEM = GG_CMEM.v
    ini.functions.DrawDist = GG_DrawDist.v
    ini.functions.FogDist = GG_FogDist.v
    ini.functions.LogDist = GG_LogDist.v
    ini.functions.Time = GG_Time.v
    ini.functions.Weather = GG_Weather.v
    ini.functions.Fovedit = GG_Fovedit.v
    ini.functions.camshake = GG_camshake.v
    ini.functions.objectwallhack = GG_objectwallhack.v
    ini.functions.objtraser = GG_objtraser.v
    ini.functions.WaterX = GG_WaterX.v
    ini.functions.driveUnderWater = GG_driveUnderWater.v
    ini.functions.rWater = GG_rWater.v
    ini.functions.trigger = GG_trigger.v
    ini.functions.esplines = GG_esplines.v
    ini.functions.espbox = GG_espbox.v
    ini.functions.bypass_tp = GG_bypass_tp.v
    ini.functions.fakemobile = GG_fakemobile.v
    ini.functions.imgClickInfState = imgClickInfState.v
    ini.functions.imgSliderInfFov = imgSliderInfFov.v
    ini.functions.imgClickInfObj = imgClickInfObj.v
    ini.functions.imgClickInfLine = imgClickInfLine.v
    ini.functions.imgSliderInfBlood = imgSliderInfBlood.v
    ini.functions.imgSliderInfRand = imgSliderInfRand.v
    ini.functions.imgClickinfClist = imgClickinfClist.v
    ini.functions.imgClickinfTorso = imgClickinfTorso.v
    ini.functions.imgClickinfGroin = imgClickinfGroin.v
    ini.functions.imgClickinfHead = imgClickinfHead.v
    ini.functions.fastwalk = script.fastwalk.v
    ini.functions.AirBreakSpeed = script.AirBreakSpeed.v
    ini.functions.lengthJump = script.lengthJump.v
    ini.functions.RapidSpeed = script.RapidSpeed.v
    ini.functions.altspeedhack = script.altspeedhack.v
    ini.functions.pMemory = script.pMemory.v
    ini.functions.pMemSize = script.pMemSize.v
    ini.functions.pDrawEdit = script.pDrawEdit.v
    ini.functions.pFogEdit = script.pFogEdit.v
    ini.functions.pTime = script.pTime.v
    ini.functions.pWeather = script.pWeather.v
    ini.functions.pFovedit = script.pFovedit.v
    ini.functions.pCamshake = script.pCamshake.v
    ini.functions.pLogEdit = script.pLogEdit.v
    ini.functions.pspam = script.pspam.v
    ini.functions.volume = script.volume.v
    ini.functions.pWaterSpeed = script.pWaterSpeed.v
    ini.functions.chamstype = script.chamstype.v
    ini.functions.radio_cbug = script.radio_cbug.v
    ini.functions.aimbot_type = script.aimbot_type.v
    ini.functions.weapon_ammo = script.weapon_ammo.v
    ini.functions.ObjectCollision = GG_ObjectCollision.v
    ini.functions.bypasstpadm = GG_bypasstpadm.v
    ini.functions.antadm = GG_antadm.v
    ini.functions.tutorial = GG_tutorial.v
    ini.functions.bypassinvi = GG_bypassinvi.v
    ini.functions.AirStealth = GG_AirStealth.v
    ini.functions.airbypass = GG_airbypass.v
    ini.functions.lista = GG_lista.v
    ini.functions.RPName = GG_RPName.v
    ini.functions.rvanka = GG_rvanka.v
    ini.functions.ChecarDroides = GG_ChecarDroides.v
    ini.functions.BlockDrugsAnimation = GG_BlockDrugsAnimation.v
    ini.functions.SpeedHackBypass = GG_SpeedHackBypass.v
    ini.functions.AirVehBypass = GG_AirVehBypass.v
    ini.functions.speedCap = script.speedCap.v
    ini.functions.OVERHP = GG_OVERHP.v
    inicfg.save(ini, MainSettingsdirectIni)
end
function settings_ini_load()
    local v104 = WATER_RPG.v
    local v105 = WATER_RPG.v
    local v106 = WATER_RPG.v
    local v107 = WATER_RPG.v
    local v108 = ini.WATER_RPG.r
    local v109 = ini.WATER_RPG.g
    local v110 = ini.WATER_RPG.b
    v107[4] = ini.WATER_RPG.a
    v106[3] = v110
    v105[2] = v109
    v104[1] = v108
    GG_GM.v = ini.functions.GM
    GG_NoFall.v = ini.functions.NoFall
    GG_autorun.v = ini.functions.autorun
    GG_InfinityRun.v = ini.functions.InfinityRun
    GG_MegaJump.v = ini.functions.MegaJump
    GG_AntiAfk.v = ini.functions.AntiAfk
    GG_InfO2.v = ini.functions.InfO2
    GG_Chams.v = ini.functions.Chams
    GG_InvertPlayer2021.v = ini.functions.InvertPlayer2021
    GG_CrazyPlayer2021.v = ini.functions.CrazyPlayer2021
    GG_FastWalk.v = ini.functions.FastWalk
    GG_AirBreak.v = ini.functions.AirBreak
    GG_FastRotation.v = ini.functions.FastRotation
    GG_InfinityAmmo.v = ini.functions.InfinityAmmo
    GG_FullSkills.v = ini.functions.FullSkills
    GG_NoReload.v = ini.functions.NoReload
    GG_bell.v = ini.functions.bell
    GG_Cbug.v = ini.functions.Cbug
    GG_NoSpread.v = ini.functions.NoSpread
    GG_SensFix.v = ini.functions.SensFix
    GG_AimBot.v = ini.functions.AimBot
    aimbot.team_ignore.v = ini.functions.aimbotteam_ignore
    aimbot.proSkipDead.v = ini.functions.aimbotproSkipDead
    aimbot.skipDead.v = ini.functions.aimbotskipDead
    aimbot.disabledOnAnim.v = ini.functions.aimbotdisabledOnAnim
    aimbot.disabledIfFriend.v = ini.functions.aimbotdisabledIfFriend
    aimbot.disabledOnAFk.v = ini.functions.aimbotdisabledOnAFk
    aimbot.safeZone.v = ini.functions.aimbotsafeZone
    aimbot.jobRadius.v = ini.functions.aimbotjobRadius
    aimbot.smoothSpeed.v = ini.functions.aimbotsmoothSpeed
    aimbot.addSmoothSpeed.v = ini.functions.aimbotaddSmoothSpeed
    GG_SilentAim.v = ini.functions.SilentAim
    GG_noCamRestore.v = ini.functions.noCamRestore
    GG_Rapid.v = ini.functions.Rapid
    GG_gtavaim.v = ini.functions.gtavaim
    GG_GMCar.v = ini.functions.GMCar
    GG_GMWheels.v = ini.functions.GMWheels
    GG_Fbike.v = ini.functions.Fbike
    GG_FC.v = ini.functions.FC
    GG_Tmode.v = ini.functions.Tmode
    GG_InfinityFuel.v = ini.functions.InfinityFuel
    GG_NoRadio.v = ini.functions.NoRadio
    GG_Water.v = ini.functions.Water
    GG_CarShot.v = ini.functions.CarShot
    GG_CarJump.v = ini.functions.CarJump
    GG_driftInCar.v = ini.functions.driftInCar
    GG_bmx.v = ini.functions.bmx
    GG_Nitro.v = ini.functions.Nitro
    GG_altspeed.v = ini.functions.altspeed
    GG_dirigirsemlicenca.v = ini.functions.dirigirsemlicenca
    GG_destrancar.v = ini.functions.destrancar
    GG_bloquearrpc.v = ini.functions.bloquearrpc
    GG_AntiCamPos.v = ini.functions.AntiCamPos
    GG_AntiAnimClear.v = ini.functions.AntiAnimClear
    GG_AntiFreeze.v = ini.functions.AntiFreeze
    GG_AntiDialog.v = ini.functions.AntiDialog
    GG_InvertVeh2021.v = ini.functions.InvertVeh2021
    GG_CrazyVeh2021.v = ini.functions.CrazyVeh2021
    GG_rifadobuzeira.v = ini.functions.rifadobuzeira
    GG_grudarexplodir.v = ini.functions.grudarexplodir
    GG_telagem.v = ini.functions.telagem
    GG_pararjogadores.v = ini.functions.pararjogadores
    GG_NameTags.v = ini.functions.NameTags
    GG_SkeletalWallHack.v = ini.functions.SkeletalWallHack
    GG_ESPVEICULOS.v = ini.functions.ESPVEICULOS
    GG_DisableUnderWaterEffects.v = ini.functions.DisableUnderWaterEffects
    GG_DisableWater.v = ini.functions.DisableWater
    GG_SUN.v = ini.functions.SUN
    GG_blur.v = ini.functions.blur
    GG_fpsboost.v = ini.functions.fpsboost
    GG_fixwater.v = ini.functions.fixwater
    GG_fmoney.v = ini.functions.fmoney
    GG_lmap.v = ini.functions.lmap
    GG_MEMORY.v = ini.functions.MEMORY
    GG_CMEM.v = ini.functions.CMEM
    GG_DrawDist.v = ini.functions.DrawDist
    GG_FogDist.v = ini.functions.FogDist
    GG_LogDist.v = ini.functions.LogDist
    GG_Weather.v = ini.functions.Weather
    GG_Fovedit.v = ini.functions.Fovedit
    GG_camshake.v = ini.functions.camshake
    GG_objectwallhack.v = ini.functions.objectwallhack
    GG_objtraser.v = ini.functions.objtraser
    GG_WaterX.v = ini.functions.WaterX
    GG_driveUnderWater.v = ini.functions.driveUnderWater
    GG_rWater.v = ini.functions.rWater
    GG_trigger.v = ini.functions.trigger
    GG_esplines.v = ini.functions.esplines
    GG_espbox.v = ini.functions.espbox
    GG_bypass_tp.v = ini.functions.bypass_tp
    GG_fakemobile.v = ini.functions.fakemobile
    imgClickInfState.v = ini.functions.imgClickInfState
    imgSliderInfFov.v = ini.functions.imgSliderInfFov
    imgClickInfObj.v = ini.functions.imgClickInfObj
    imgClickInfLine.v = ini.functions.imgClickInfLine
    imgSliderInfBlood.v = ini.functions.imgSliderInfBlood
    imgSliderInfRand.v = ini.functions.imgSliderInfRand
    imgClickinfClist.v = ini.functions.imgClickinfClist
    imgClickinfTorso.v = ini.functions.imgClickinfTorso
    imgClickinfGroin.v = ini.functions.imgClickinfGroin
    imgClickinfHead.v = ini.functions.imgClickinfHead
    script.fastwalk.v = ini.functions.fastwalk
    script.AirBreakSpeed.v = ini.functions.AirBreakSpeed
    script.lengthJump.v = ini.functions.lengthJump
    script.RapidSpeed.v = ini.functions.RapidSpeed
    script.altspeedhack.v = ini.functions.altspeedhack
    script.pMemory.v = ini.functions.pMemory
    script.pMemSize.v = ini.functions.pMemSize
    script.pDrawEdit.v = ini.functions.pDrawEdit
    script.pFogEdit.v = ini.functions.pFogEdit
    script.pTime.v = ini.functions.pTime
    script.pWeather.v = ini.functions.pWeather
    script.pFovedit.v = ini.functions.pFovedit
    script.pCamshake.v = ini.functions.pCamshake
    script.pLogEdit.v = ini.functions.pLogEdit
    script.pspam.v = ini.functions.pspam
    script.volume.v = ini.functions.volume
    script.chamstype.v = ini.functions.chamstype
    script.radio_cbug.v = ini.functions.radio_cbug
    script.aimbot_type.v = ini.functions.aimbot_type
    script.pWaterSpeed.v = ini.functions.pWaterSpeed
    script.weapon_ammo.v = ini.functions.weapon_ammo
    GG_ObjectCollision.v = ini.functions.ObjectCollision
    GG_bypasstpadm.v = ini.functions.bypasstpadm
    GG_antadm.v = ini.functions.antadm
    GG_tutorial.v = ini.functions.tutorial
    GG_bypassinvi.v = ini.functions.bypassinvi
    GG_AirStealth.v = ini.functions.AirStealth
    GG_airbypass.v = ini.functions.airbypass
    GG_lista.v = ini.functions.lista
    GG_RPName.v = ini.functions.RPName
    GG_rvanka.v = ini.functions.rvanka
    GG_ChecarDroides.v = ini.functions.ChecarDroides
    GG_BlockDrugsAnimation.v = ini.functions.BlockDrugsAnimation
    GG_SpeedHackBypass.v = ini.functions.SpeedHackBypass
    GG_AirVehBypass.v = ini.functions.AirVehBypass
    script.speedCap.v = ini.functions.speedCap
    GG_OVERHP.v = ini.functions.OVERHP
end
function GetActiveKey()
    script.activekey.v = ini.functions.activekey
end
function GetSMSsettings()
    script.receive_sound.v = ini.functions.receive_sound
    script.sms_in_chat.v = ini.functions.sms_in_chat
    script.clean_on_sent.v = ini.functions.clean_on_sent
end
imgClickInfState = vu2.ImBool(false)
imgSliderInfFov = vu2.ImFloat(100)
imgClickInfObj = vu2.ImBool(true)
imgClickInfVeh = vu2.ImBool(true)
imgClickInfLine = vu2.ImBool(true)
imgSliderInfBlood = vu2.ImFloat(100)
imgSliderInfRand = vu2.ImFloat(100)
imgClickinfClist = vu2.ImBool(false)
imgClickinfTorso = vu2.ImBool(true)
imgClickinfGroin = vu2.ImBool(false)
imgClickinfHead = vu2.ImBool(false)
function DisableAllBody(p111, p112, p113)
    imgClickinfTorso.v = p111
    imgClickinfGroin.v = p112
    imgClickinfHead.v = p113
end
function StartInKey()
    tarPed = - 1
    imgClickInfState.v = not imgClickInfState.v
end
function v13.onSendAimSync(p114)
    camMode = p114.camMode
    if imgClickInfState.v then
        weap = getCurrentCharWeapon(PLAYER_PED)
        local _, v115 = sampGetPlayerIdByCharHandle(PLAYER_PED)
        if weap ~= nil and (GetWeaponOkay(weap) and not (isCharDead(PLAYER_PED) or sampIsPlayerPaused(v115))) then
            camX = p114.camPos.x
            camY = p114.camPos.y
            camZ = p114.camPos.z
            frontX = p114.camFront.x
            frontY = p114.camFront.y
            frontZ = p114.camFront.z
            CheckTarget()
        end
    end
end
function v13.onSendBulletSync(p116)
    if imgClickInfState.v and (tarPed ~= - 1 and (stopwork ~= 1 and (p116.targetType ~= 1 and (p116.weaponId ~= nil and GetWeaponOkay(p116.weaponId))))) then
        local v117, v118 = sampGetPlayerIdByCharHandle(tarPed)
        if v117 then
            respol = 0
            if imgClickinfClist.v then
                local _, v119 = sampGetPlayerIdByCharHandle(PLAYER_PED)
                color0 = sampGetPlayerColor(v119)
                color1 = sampGetPlayerColor(v118)
                if color0 ~= nil and (color1 ~= nil and color0 == color1) then
                    respol = 1
                end
            end
            if respol == 0 then
                local v120, v121, v122 = getCharCoordinates(tarPed)
                local v123, v124, v125 = getCharCoordinates(PLAYER_PED)
                dist = getDistanceBetweenCoords3d(v123, v124, v125, v120, v121, v122)
                wdist = GetWeaponDist(p116.weaponId)
                rand = imgSliderInfRand.v
                if rand ~= nil and (dist ~= nil and (wdist ~= nil and (dist > 0 and (dist < wdist and (math.random(100) < rand and (isCharDead(tarPed) == false and sampIsPlayerPaused(v118) == false)))))) then
                    randX = RandomFloat(- 0.25, 0.25)
                    randY = RandomFloat(- 0.25, 0.25)
                    randZ = RandomFloat(- 0.8, 0.8)
                    if math.abs(randX) < 0.01 then
                        randX = 0.01
                    end
                    if math.abs(randY) < 0.01 then
                        randY = 0.01
                    end
                    if math.abs(randZ) < 0.01 then
                        randZ = 0.01
                    end
                    p116.targetType = 1
                    p116.targetId = v118
                    p116.origin = {
                        x = v123 + randX,
                        y = v124 + randY,
                        z = v125 + randZ
                    }
                    p116.target = {
                        x = v120 + randX,
                        y = v121 + randY,
                        z = v122 + randZ
                    }
                    p116.center = {
                        x = randX,
                        y = randY,
                        z = randZ
                    }
                    local v126, v127
                    if imgClickinfHead.v then
                        v126 = RandomFloat(0.7, 0.8)
                        v127 = 9
                    elseif imgClickinfGroin.v then
                        v126 = RandomFloat(- 0.3, - 0.2)
                        v127 = 4
                    else
                        v126 = RandomFloat(- 0.1, 0.6)
                        v127 = 3
                    end
                    sampSendGiveDamage(v118, GetWeaponDamage(p116.weaponId), p116.weaponId, v127)
                    if imgClickInfLine.v then
                        fireSingleBullet(v123, v124, v125 + RandomFloat(0.5, 0.7), v120 + randX, v121 + randY, v122 + v126, 1)
                    end
                    if imgSliderInfBlood.v > 0 then
                        addBlood(v120 + randX, v121 + randY, v122 + v126, 0, 0, 0, imgSliderInfBlood.v, tarPed)
                    end
                end
            end
        end
    end
end
function CheckTarget()
    mped = getAllChars()
    local v128, v129, v130 = getCharCoordinates(PLAYER_PED)
    tdist = imgSliderInfFov.v
    weap = getCurrentCharWeapon(PLAYER_PED)
    wdist = GetWeaponDist(weap)
    if tdist ~= nil and (weap ~= nil and wdist ~= nil) then
        tarPed = - 1
        local v131, v132, v133 = pairs(mped)
        while true do
            local v134
            v133, v134 = v131(v132, v133)
            if v133 == nil then
                break
            end
            if v134 ~= PLAYER_PED then
                local v135, v136, v137 = getCharCoordinates(v134)
                if isLineOfSightClear(v128, v129, v130, v135, v136, v137, not imgClickInfObj.v, not imgClickInfVeh.v, false, not imgClickInfObj.v, false) then
                    local v138, v139 = sampGetPlayerIdByCharHandle(v134)
                    if v138 then
                        ndist = FacingToCoords(v135, v136, tdist)
                        dist = getDistanceBetweenCoords3d(v128, v129, v130, v135, v136, v137)
                        if ndist ~= nil and (dist ~= nil and (ndist < tdist and (dist and (dist < wdist and not (isCharDead(v134) or sampIsPlayerPaused(v139)))))) then
                            tarPed = v134
                            tdist = ndist
                        end
                    end
                end
            end
        end
    end
end
function RandomFloat(p140, p141)
    return p140 + math.random() * (p141 - p140)
end
function VectorySize(p142, p143, p144)
    return math.sqrt(p142 * p142 + p143 * p143, p144 * p144)
end
function GetWeaponOkay(p145)
    return (22 <= p145 and p145 <= 34 or p145 == 38) and 1 or 0
end
function GetWeaponName(p146)
    namearray = {
        [22] = "9mm",
        [23] = "Silenced 9mm",
        [24] = "Desert Eagle",
        [25] = "Shotgun",
        [26] = "Sawnoff Shotgun",
        [27] = "Combat Shotgun",
        [28] = "Micro SMG/Uzi",
        [29] = "MP5",
        [30] = "AK-47",
        [31] = "M4",
        [32] = "Tec-9",
        [33] = "Country Rifle",
        [34] = "Sniper Rifle",
        [38] = "Minigun"
    }
    return namearray[p146]
end
function GetWeaponDamage(p147)
    dmgarray = {
        [22] = 8.25,
        [23] = 13.2,
        [24] = 46.2,
        [25] = 3.3,
        [26] = 3.3,
        [27] = 4.95,
        [28] = 6.6,
        [29] = 8.25,
        [30] = 9.9,
        [31] = 9.9,
        [32] = 6.6,
        [33] = 24.75,
        [34] = 41.25,
        [38] = 46.2
    }
    return dmgarray[p147]
end
function GetWeaponDist(p148)
    distarray = {
        [22] = 35,
        [23] = 35,
        [24] = 35,
        [25] = 40,
        [26] = 35,
        [27] = 40,
        [28] = 35,
        [29] = 45,
        [30] = 70,
        [31] = 90,
        [32] = 35,
        [33] = 95,
        [34] = 320,
        [38] = 75
    }
    return distarray[p148]
end
function FacingToCoords(p149, p150, p151)
    local v152 = camX + frontX * 50
    local v153 = camY + frontY * 50
    local v154, v155, _ = getCharCoordinates(PLAYER_PED)
    dist = VectorySize(v154 - p149, v155 - p150, 0)
    ndist = 7 - dist / 5
    if ndist < 0 then
        ndist = 0
    end
    uang = math.atan2(v154 - v152, v155 - v153)
    tang = math.atan2(v154 - p149, v155 - p150)
    ugrad = math.deg(uang) + ndist
    tgrad = math.deg(tang)
    if tgrad - p151 >= ugrad or tgrad + p151 <= ugrad then
        return nil
    elseif ugrad <= tgrad then
        return tgrad - ugrad
    else
        return ugrad - tgrad
    end
end
function CalculateQuat(p156, p157, p158)
    b = p156 * math.pi / 360
    h = p157 * math.pi / 360
    a = p158 * math.pi / 360
    local v159 = math.cos(h)
    local v160 = math.cos(a)
    local v161 = math.cos(b)
    local v162 = math.sin(h)
    local v163 = math.sin(a)
    local v164 = math.sin(b)
    qw = v159 * v160 * v161 - v162 * v163 * v164
    qx = v162 * v163 * v161 + v159 * v160 * v164
    qy = v162 * v160 * v161 + v159 * v163 * v164
    qz = v159 * v163 * v161 - v162 * v160 * v164
    return qw, qx, qy, qz
end
function BeginToPoint(p165, p166, p167, p168, p169, p170)
    repeat
        local v171, v172, _ = GetCoordinates()
        dist = getDistanceBetweenCoords3d(p165, p166, p167, v171, v172, p167)
        setAngle(p165, p166, dist, 0.08)
        MovePlayer(p169, p170)
        wait(0)
    until dist < p168
end
function MovePlayer(p173, p174)
    setGameKeyState(1, p173)
    if p174 then
        setGameKeyState(16, 255)
    end
end
function setAngle(p175, p176, p177, p178)
    source_x = fix(representIntAsFloat(readMemory(11989576, 4, false)))
    source_z = fix(representIntAsFloat(readMemory(11989592, 4, false))) + math.pi
    angle = GetAngleBeetweenTwoPoints(p175, p176) - source_z - math.pi
    if p177 > 1.8 then
        if angle <= - 0.1 or angle >= 0.03 then
            if angle >= - 5.7 or angle <= - 5.93 then
                if angle >= - 6 or angle <= - 6.4 then
                    if angle <= 0.04 then
                        if angle >= - 3.5 or angle <= - 5.67 then
                            setCameraPositionUnfixed(- 0.3, fix(representIntAsFloat(readMemory(11989592, 4, false))) - p178)
                        else
                            setCameraPositionUnfixed(- 0.3, fix(representIntAsFloat(readMemory(11989592, 4, false))) + p178)
                        end
                    else
                        setCameraPositionUnfixed(- 0.3, fix(representIntAsFloat(readMemory(11989592, 4, false))) + p178)
                    end
                else
                    setCameraPositionUnfixed(- 0.3, GetAngleBeetweenTwoPoints(p175, p176))
                end
            else
                setCameraPositionUnfixed(- 0.3, GetAngleBeetweenTwoPoints(p175, p176))
            end
        else
            setCameraPositionUnfixed(- 0.3, GetAngleBeetweenTwoPoints(p175, p176))
        end
    else
        setCameraPositionUnfixed(source_x, GetAngleBeetweenTwoPoints(p175, p176))
    end
end
function GetCoordinates()
    if not isCharInAnyCar(playerPed) then
        return getCharCoordinates(playerPed)
    end
    car = storeCarCharIsInNoSave(playerPed)
    return getCarCoordinates(car)
end
function GetAngleBeetweenTwoPoints(p179, p180)
    local v181, v182, _ = getCharCoordinates(playerPed)
    plus = 0
    mode = 1
    if v181 < p179 and p180 < v182 then
        plus = math.pi / 2
        mode = 2
    end
    if v181 < p179 and v182 < p180 then
        plus = math.pi
    end
    if p179 < v181 and v182 < p180 then
        plus = math.pi * 1.5
        mode = 2
    end
    local v183 = p179 - v181
    local v184 = p180 - v182
    local v185 = math.abs(v183)
    local v186 = math.abs(v184)
    local v187
    if mode ~= 1 then
        v187 = v185 / v186
    else
        v187 = v186 / v185
    end
    return math.atan(v187) + plus
end
function message(p188)
    return sampAddChatMessage(p188, 16711680)
end
sampanim = {
    PISS = "68",
    JETPACK = "2",
    DANCE1 = "5",
    DANCE2 = "8",
    HANDSUP = "10",
    USE_PHONE = "11",
    ["GET BEER"] = "20",
    ["GET WINE"] = "22",
    ["GET SPRUNK"] = "23",
    ["GET SIGAR"] = "21",
    CUFFED = "24",
    CARRY = "25"
}
ToggleButtons = {
    {
        "GM"
    },
    {
        "NoFall"
    },
    {
        "autorun"
    },
    {
        "InfinityRun"
    },
    {
        "MegaJump"
    },
    {
        "AntiStun"
    },
    {
        "AntiAfk"
    },
    {
        "Fugga"
    },
    {
        "InfO2"
    },
    {
        "Chams"
    },
    {
        "Invisible"
    },
    {
        "InvertPlayer2021"
    },
    {
        "CrazyPlayer2021"
    },
    {
        "FastWalk"
    },
    {
        "FastRotation"
    },
    {
        "AirBreak"
    },
    {
        "InfinityAmmo"
    },
    {
        "FullSkills"
    },
    {
        "NoReload"
    },
    {
        "bell"
    },
    {
        "Cbug"
    },
    {
        "NoSpread"
    },
    {
        "SensFix"
    },
    {
        "AimBot"
    },
    {
        "noCamRestore"
    },
    {
        "SilentAim"
    },
    {
        "Rapid"
    },
    {
        "damager"
    },
    {
        "cdamage"
    },
    {
        "gtavaim"
    },
    {
        "GMCar"
    },
    {
        "GMWheels"
    },
    {
        "Fbike"
    },
    {
        "Fbike"
    },
    {
        "FC"
    },
    {
        "Tmode"
    },
    {
        "InfinityFuel"
    },
    {
        "NoRadio"
    },
    {
        "driveUnderWater"
    },
    {
        "Water"
    },
    {
        "CarShot"
    },
    {
        "CarJump"
    },
    {
        "bmx"
    },
    {
        "Nitro"
    },
    {
        "driftInCar"
    },
    {
        "altspeed"
    },
    {
        "dirigirsemlicenca"
    },
    {
        "destrancar"
    },
    {
        "bloquearrpc"
    },
    {
        "AntiCamPos"
    },
    {
        "AntiAnimClear"
    },
    {
        "AntiFreeze"
    },
    {
        "AntiDialog"
    },
    {
        "InvertVeh2021"
    },
    {
        "CrazyVeh2021"
    },
    {
        "rifadobuzeira"
    },
    {
        "grudarexplodir"
    },
    {
        "telagem"
    },
    {
        "pararjogadores"
    },
    {
        "NameTags"
    },
    {
        "SkeletalWallHack"
    },
    {
        "ESPVEICULOS"
    },
    {
        "DisableUnderWaterEffects"
    },
    {
        "DisableWater"
    },
    {
        "SUN"
    },
    {
        "FPS"
    },
    {
        "blur"
    },
    {
        "fpsboost"
    },
    {
        "fixwater"
    },
    {
        "anticrasher"
    },
    {
        "fmoney"
    },
    {
        "lmap"
    },
    {
        "MEMORY"
    },
    {
        "CMEM"
    },
    {
        "DrawDist"
    },
    {
        "FogDist"
    },
    {
        "LogDist"
    },
    {
        "Time"
    },
    {
        "Weather"
    },
    {
        "Fovedit"
    },
    {
        "camshake"
    },
    {
        "spam"
    },
    {
        "bspam"
    },
    {
        "objectwallhack"
    },
    {
        "objtraser"
    },
    {
        "WaterX"
    },
    {
        "rWater"
    },
    {
        "trigger"
    },
    {
        "esplines"
    },
    {
        "espbox"
    },
    {
        "bypass_tp"
    },
    {
        "fakemobile"
    },
    {
        "WetRoads"
    },
    {
        "SandParticle"
    },
    {
        "BladeCollision"
    },
    {
        "SpeedLimit"
    },
    {
        "RailsResistance"
    },
    {
        "SpawnFix"
    },
    {
        "PauseMenuFix"
    },
    {
        "AirCraftExplosionFix"
    },
    {
        "HydraSniper"
    },
    {
        "ClickMap"
    },
    {
        "MainTheme"
    },
    {
        "ObjectCollision"
    },
    {
        "bypasstpadm"
    },
    {
        "antadm"
    },
    {
        "tutorial"
    },
    {
        "bypassinvi"
    },
    {
        "lista"
    },
    {
        "BlockDrugsAnimation"
    },
    {
        "RPName"
    },
    {
        "rvanka"
    },
    {
        "ChecarDroides"
    },
    { "SpeedHackBypass" },
    { "AirVehBypass" },
    {
        "OVERHP"
    }
}
local v189, v190, v191 = pairs(ToggleButtons)
local vu192 = vu54
local vu193 = vu53
local vu194 = vu3
local vu195 = vu56
local vu196 = vu55
local vu197 = vu52
local vu198 = vu10
local vu199 = vu42
local vu200 = vu2
while true do
    local v201
    v191, v201 = v189(v190, v191)
    if v191 == nil then
        break
    end
    _G["GG_" .. v201[1] ] = vu200.ImBool(false)
end
local vu202 = {
    70,
    71,
    72,
    76,
    77,
    78,
    79
}
local vu203 = vu194.clock()
UpdateLog = {
    "- Fixed,Improuved & Advanced Update system\n",
    "- New settings panel"
}
script = {
    start_updating = false,
    window = vu200.ImBool(false),
    admin_panel = vu200.ImBool(ADMIN_MODE),
    sms_window = vu200.ImBool(false),
    iHUD = vu200.ImBool(false),
    vHUD = vu200.ImBool(false),
    cHUD = vu200.ImBool(false),
    StaminaHUD = vu200.ImBool(false),
    page = 8,
    fastwalk = vu200.ImInt(1),
    lengthJump = vu200.ImFloat(0.25),
    AirBreakSpeed = vu200.ImFloat(2.0),
    RapidSpeed = vu200.ImInt(1),
    altspeedhack = vu200.ImInt(100),
    pMemory = vu200.ImInt(512),
    pMemSize = vu200.ImInt(50),
    pDrawEdit = vu200.ImInt(800),
    pFogEdit = vu200.ImInt(200),
    pTime = vu200.ImInt(1),
    pWeather = vu200.ImInt(1),
    pFovedit = vu200.ImInt(70),
    pCamshake = vu200.ImInt(10),
    pLogEdit = vu200.ImInt(500),
    ip1 = vu200.ImBuffer(50),
    name1 = vu200.ImBuffer(25),
    speedCap = vu200.ImInt(50),
    port1 = vu200.ImBuffer(10),
    pspam = vu200.ImInt(0),
    textspam = vu200.ImBuffer(1000),
    volume = vu200.ImInt(1),
    radio_button = vu200.ImInt(0),
    radio_cbug = vu200.ImInt(0),
    GG_bloquearrpc = vu200.ImBool(false),
    GG_dirigirsemlicenca = vu200.ImBool(false),   -- O botão principal de ligar/desligar
    aimbot_type = vu200.ImInt(0),
    healthimg = vu200.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\MENU DOS CRIA\\textures\\hud\\icons\\health.png"),
    armourimg = vu200.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\MENU DOS CRIA\\textures\\hud\\icons\\armour.png"),
    sprintimg = vu200.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\MENU DOS CRIA\\textures\\hud\\icons\\sprint.png"),
    breathimg = vu200.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\MENU DOS CRIA\\textures\\hud\\icons\\breath.png"),
    menulogo = (function()
        local base = getGameDirectory() .. "\\moonloader\\MENU DOS CRIA\\logo"
        local exts = {".png", ".tga", ".dds", ".jpg"}
        for i, ext in ipairs(exts) do
            local path = base .. ext
            if doesFileExist(path) then
                local tex = vu200.CreateTextureFromFile(path)
                if tex ~= nil then
                    return tex
                end
            end
        end
        return nil
    end)(),
    pWaterSpeed = vu200.ImInt(1),
    chamstype = vu200.ImInt(0),
    activekey = vu200.ImInt(0),
    weapon_ammo = vu200.ImInt(100),
    unlock_carID = vu200.ImBuffer(11),
    warp_carID = vu200.ImBuffer(11),
    get_carID = vu200.ImBuffer(11),
    explode_carID = vu200.ImBuffer(11),
    weapons_path = getGameDirectory() .. "\\moonloader\\MENU DOS CRIA\\textures\\hud\\picker\\weapons\\",
    peds_path = getGameDirectory() .. "\\moonloader\\MENU DOS CRIA\\textures\\hud\\picker\\peds\\",
    NextStep = vu200.ImInt(1),
    message_input = vu200.ImBuffer(80),
    handle_input = vu200.ImBuffer(21),
    clean_on_sent = vu200.ImBool(false),
    receive_sound = vu200.ImBool(false),
    sms_in_chat = vu200.ImBool(false),
    messages_color = vu200.ImInt(0),
    readdy = false,
    nops_page = 1,
    nops_filter = vu200.ImBuffer(256),
    bypass = false,
    Skin_Editor = false,
    SettingsLEFT = false,
    skins_filter = vu200.ImBuffer(256)
}
local vu204 = - 1
aimbot = {
    team_ignore = vu200.ImBool(false),
    proSkipDead = vu200.ImBool(false),
    skipDead = vu200.ImBool(false),
    disabledOnAnim = vu200.ImBool(false),
    disabledIfFriend = vu200.ImBool(false),
    disabledOnAFk = vu200.ImBool(false),
    safeZone = vu200.ImFloat(1),
    jobRadius = vu200.ImFloat(80),
    smoothSpeed = vu200.ImFloat(5),
    addSmoothSpeed = vu200.ImFloat(1)
}
weapons_pictures = {}
ped_pictures = {}
keys = {
    quick_teleport1 = 88,
    quick_teleport2 = 89
}
teleporter = {
    quick_teleport = vu200.ImBool(false),
    current_btn = 1,
    current_coords = vu200.ImBool(false),
    auto_z = vu200.ImBool(false),
    show = vu200.ImBool(false),
    shotcut = vu200.ImBool(false),
    coords = vu200.ImBuffer(10000),
    location_name = vu200.ImBuffer(24),
    search_text = vu200.ImBuffer(60),
    radio_button = vu200.ImInt(0)
}
function LoadJson(p205)
    full_path = getWorkingDirectory() .. "/MENU DOS CRIA/config/teleport/" .. p205 .. ".json"
    if not doesFileExist(full_path) then
        return {}
    end
    file = io.open(full_path, "r")
    local v206 = decodeJson(file:read("*a"))
    file:close()
    return v206
end
function SaveJson(p207, p208)
    full_path = getWorkingDirectory() .. "/MENU DOS CRIA/config/teleport/" .. p207 .. ".json"
    local v209 = assert(io.open(full_path, "w"))
    v209:write(encodeJson(p208))
    v209:close()
end
coordinates = LoadJson("Teleporter")
function Teleport(pu210, pu211, pu212, pu213)
    local v220 = pu213 == nil and 0 or pu213
    if pu210 == nil then
        local v221
        v221, pu210, pu211, pu212 = getTargetBlipCoordinates()
        _ = v221
        v220 = 0
    end
    if v220 == 0 then
        pu212 = pu212 + 3
    end
    if teleporter.auto_z.v then
        pu212 = getGroundZFor3dCoord(pu210, pu211, pu212)
    end
    setCharInterior(PLAYER_PED, v220)
    setInteriorVisible(v220)
    clearExtraColours(true)
    requestCollision(pu210, pu211)
    activateInteriorPeds(true)
    setCharCoordinates(PLAYER_PED, pu210, pu211, pu212)
    loadScene(pu210, pu211, pu212)
end
function ShowEntry(p222, p223, p224, p225, p226)
    if vu200.MenuItem(p222, "", false, true) then
        Teleport(p223, p224, p225, p226)
    end
    vu200.Hint("Right click over any of these entries to remove them")
    if vu200.IsItemClicked(1) then
        coordinates[p222] = nil
        SaveJson("Teleporter", coordinates)
        coordinates = LoadJson("Teleporter")
    end
end
function iniciarRifaNoAlvo(targetID)
    lua_thread.create(function()
        -- SALVA A POSIÇÃO INICIAL ANTES DE COMEÇAR
        local spawnX, spawnY, spawnZ = getCharCoordinates(PLAYER_PED)
        local startTime = os.clock() -- Registra o momento que começou
        
        while rifaTargetActive do
            -- VERIFICAÇÃO DE TEMPO: Se passar de 3 segundos, desliga
            if os.clock() - startTime > 3.0 then
                rifaTargetActive = false
                break
            end

            local result, targetChar = sampGetCharHandleBySampPlayerId(targetID)
            if result and doesCharExist(targetChar) then
                local tx, ty, tz = getCharCoordinates(targetChar)
                
                for id = 0, 1999 do
                    -- Verifica se o tempo acabou ou se foi desligado manualmente dentro do loop longo
                    if not rifaTargetActive or (os.clock() - startTime > 3.0) then 
                        rifaTargetActive = false
                        break 
                    end
                    
                    local resCar, car = sampGetCarHandleBySampVehicleId(id)
                    if resCar and doesVehicleExist(car) then
                        local cx, cy, cz = getCarCoordinates(car)
                        
                        if getDistanceBetweenCoords3d(tx, ty, tz, cx, cy, cz) < 600 then
                            if car ~= ultimoCarroId then
                                warpCharIntoCar(PLAYER_PED, car)
                                setCharCoordinates(PLAYER_PED, tx, ty + 2.0, tz - 1)
                                wait(60)
                                removeCharFromCarMaintainPosition(PLAYER_PED, car)
                                setCharCoordinates(PLAYER_PED, tx, ty, tz - 0.6)
                                ultimoCarroId = car
                            end
                        end
                    end
                end
            else
                rifaTargetActive = false
                break
            end
            wait(100) -- Reduzi o wait final para ele ser mais rápido nesses 3 segundos
        end
        
        -- TELEPORTA DE VOLTA PARA A POSIÇÃO SALVA NO INÍCIO
        wait(50)
        setCharCoordinates(PLAYER_PED, spawnX, spawnY, spawnZ)
    end)
end
function TeleportBtn()
    local v227, v228, v229 = getCharCoordinates(PLAYER_PED)
    vu200.Text(string.format("Player coordinates: %d, %d, %d ", math.floor(v227), math.floor(v228), math.floor(v229)))
    vu200.Text("Player location: " .. calculateZone(v227, v228, v229))
    vu200.Separator()
    vu200.Columns(2, nil, false)
    vu200.Checkbox("Quick teleport", teleporter.quick_teleport)
    vu200.HintTooltip("Teleport to marker using (X + Y) key combinartion")
    vu200.Checkbox("Get ground coord", teleporter.auto_z)
    vu200.HintTooltip("Get Z ground coordinates of your coordinates")
    vu200.NextColumn()
    vu200.Checkbox("ByPass teleport", GG_bypass_tp)
    if GG_bypass_tp.v and not estavoando then
        iniciarVooBypass()
    end
    vu200.HintTooltip("bypass the anticheat when teleport")
    vu200.Checkbox("Insert coordinates", teleporter.current_coords)
    vu200.HintTooltip("Automatically inserts coordinates in the text field")
    vu200.Columns(1)
    vu200.InputText("Coordinates", teleporter.coords)
    if teleporter.current_coords.v then
        local v230, v231, v232 = getCharCoordinates(PLAYER_PED)
        teleporter.coords.v = string.format("%d,  %d,  %d", math.floor(v230), math.floor(v231), math.floor(v232))
    end
    vu200.HintTooltip("Enter XYZ coordinates.\nFormat : X, Y, Z")
    if vu200.Button(vu8.ICON_FA_MAP .. " Teleport to coord", vu200.ImVec2((vu200.GetWindowWidth() - 13) / 2, 30)) then
        local v233, v234, v235 = teleporter.coords.v:match("([^,]+),([^,]+),([^,]+)")
        Teleport(v233, v234, v235, nil)
    end
    vu200.SameLine()
    if vu200.Button(vu8.ICON_FA_MAP_MARKER .. " Teleport to marker", vu200.ImVec2((vu200.GetWindowWidth() - 13) / 2, 30)) then
        Teleport()
    end
end
function ChangerSkinNewEdition(p255)
    requestModel(p255)
    loadAllModelsNow()
    setPlayerModel(PLAYER_HANDLE, p255)
end
script.search_veh = vu200.ImBuffer(64)
Navication = { MainPanel = 1 } 
script.aba_lista = 1
EsconderOcupadosVeic = {v = false}
script.selected_vehicle_id = -1
script.selected_player_id = -1
function vehicle_list_page()
    -- SE ESTIVER NA PÁGINA 1, MOSTRA VEÍCULOS
    if Navication.MainPanel == 1 then
        
        -- BARRA SUPERIOR COM BOTÃO PRÓXIMO
        vu200.BeginChild("Nav_Top", vu200.ImVec2(520, 25), false)
                
                vu200.SameLine()
                vu200.SetCursorPosX(330) -- Ajusta a posição para a direita

                -- Deixando o botão invisível
                vu200.PushStyleColor(vu200.Col.Button, vu200.ImVec4(0, 0, 0, 0)) -- Fundo Transparente
                vu200.PushStyleColor(vu200.Col.ButtonHovered, vu200.ImVec4(1, 1, 1, 0.1)) -- Leve brilho ao passar o mouse
                vu200.PushStyleColor(vu200.Col.ButtonActive, vu200.ImVec4(1, 1, 1, 0.2)) -- Brilho ao clicar
                
                if vu200.Button("PROXIMO " .. vu8.ICON_FA_ARROW_RIGHT, vu200.ImVec2(110, 25)) then
                    Navication.MainPanel = 2
                end
                
                vu200.PopStyleColor(3) -- Remove as 3 cores alteradas
            vu200.EndChild()
            
            vu200.Spacing()

        -- SEU CÓDIGO ORIGINAL DE VEÍCULOS (COLUNA ESQUERDA)
        vu200.BeginGroup()
            vu200.BeginChild("##listaveiculos", vu200.ImVec2(240, 270), true, vu200.WindowFlags.NoScrollbar)
                vu200.Text(vu8.ICON_FA_CAR .. " VEICULOS")
                vu200.Separator()
                for _, vHandle in ipairs(getAllVehicles()) do
                    if doesVehicleExist(vHandle) then
                        local result, sID = sampGetVehicleIdByCarHandle(vHandle)
                        if result then
                            local driver = getDriverOfCar(vHandle)
                            local ocupado = doesCharExist(driver)
                            if not (EsconderOcupadosVeic.v and ocupado) then
                                local model = getCarModel(vHandle)
                                local carName = getCarNamebyModel(model) or "Desconhecido"
                                local corNome = ocupado and vu200.ImVec4(1.0, 0.2, 0.2, 1.0) or vu200.ImVec4(0.2, 1.0, 0.2, 1.0)
                                vu200.Text(string.format("[%d] ", sID))
                                vu200.SameLine()
                                vu200.PushStyleColor(vu200.Col.Text, corNome)
                                local isSelected = (script.selected_vehicle_id == sID)
                                if vu200.Selectable(carName .. "##" .. sID, isSelected) then
                                    script.selected_vehicle_id = sID
                                end
                                if vu200.IsItemHovered() and vu200.IsMouseDoubleClicked(0) then
                                    script.selected_vehicle_id = sID
                                    GetVehicle(sID)
                                    lua_thread.create(function()
                                    wait(100) -- Aguarda o veículo carregar na stream
                                    local result, veh = sampGetCarHandleBySampVehicleId(sID)
                                    if result and veh then 
                                    fixCar(veh) -- Repara visual e motor
                                    setCarHealth(veh, 1000) -- Garante vida máxima
                                end
                            end)
                        end
                                vu200.PopStyleColor(1)
                                vu200.SameLine()
                                vu200.Text(ocupado and "[OCUPADO]" or "[LIVRE]")
                            end
                        end
                    end
                end
            vu200.EndChild()
            vu200.Spacing()
            vu200.BeginChild("##ConfigVeh", vu200.ImVec2(240, 70), true)
                vu200.Text(vu8.ICON_FA_COG .. " OPCOES")
                vu200.Separator()
                vu200.ToggleButton("toggle_esconder##veh", "ESCONDER OCUPADOS", 210, EsconderOcupadosVeic)
            vu200.EndChild()
        vu200.EndGroup()

        vu200.SameLine(nil, 15)

        -- SEU CÓDIGO ORIGINAL (COLUNA DIREITA)
        local larguraRestante = vu200.GetContentRegionAvail().x
        vu200.BeginChild("##OpcoesVeic", vu200.ImVec2(larguraRestante, 349), true)
            vu200.Text(vu8.ICON_FA_GAMEPAD .. " ACOES DO VEICULO")
            vu200.Separator()
            if script.selected_vehicle_id == -1 then
                vu200.TextWrapped("Selecione um carro na lista ao lado...")
            else
                vu200.Text("VEICULO: " .. script.selected_vehicle_id)
                vu200.Spacing()
                if vu200.Button("PUXAR PEGANDO FOGO", vu200.ImVec2(180, 30)) then
                    GetVehicle(script.selected_vehicle_id)
                    lua_thread.create(function()
                        wait(100)
                        local result, handle = sampGetCarHandleBySampVehicleId(script.selected_vehicle_id)
                        if result and handle then 
                        setCarHealth(handle, 249.0) -- Deixa pegando fogo
                        setCarRoll(handle, 180.0)   -- Vira de cabeça para baixo
                    end
                end)
            end
                vu200.Spacing()
                if vu200.Button("PUXAR NORMAL", vu200.ImVec2(180, 30)) then
                    GetVehicle(script.selected_vehicle_id)
                end
            end
        vu200.EndChild()

    -- SE ESTIVER NA PÁGINA 2, CHAMA A FUNÇÃO DE JOGADORES
    elseif Navication.MainPanel == 2 then
        jogador_list_page()
    end
end
function jogador_list_page()
    vu200.BeginGroup()
        -- Botão para Voltar para Veículos
        vu200.BeginChild("Nav_Back", vu200.ImVec2(520, 25), false)
        vu200.SameLine()
                vu200.SetCursorPosX(350) -- Ajusta a posição para a direita

                -- Deixando o botão invisível
                vu200.PushStyleColor(vu200.Col.Button, vu200.ImVec4(0, 0, 0, 0)) -- Fundo Transparente
                vu200.PushStyleColor(vu200.Col.ButtonHovered, vu200.ImVec4(1, 1, 1, 0.1)) -- Leve brilho ao passar o mouse
                vu200.PushStyleColor(vu200.Col.ButtonActive, vu200.ImVec4(1, 1, 1, 0.2)) -- Brilho ao clicar
            if vu200.Button(vu8.ICON_FA_ARROW_LEFT .. " VOLTAR", vu200.ImVec2(110, 25)) then
                Navication.MainPanel = 1
            end
        vu200.PopStyleColor(3) -- Remove as 3 cores alteradas
            vu200.EndChild()
            
            vu200.Spacing()

        -- 2. COLUNA ESQUERDA: LISTA DE JOGADORES NA STREAM
        vu200.BeginGroup()
            vu200.BeginChild("##listajogadores", vu200.ImVec2(220, 242), true)
                vu200.Text(vu8.ICON_FA_USERS .. " JOGADORES")
                vu200.Separator()
                
                -- Loop para pegar jogadores próximos
                for i = 0, 1000 do
                    if sampIsPlayerConnected(i) then
                        -- Verifica se o jogador está na stream (perto de você)
                        local result, charHandle = sampGetCharHandleBySampPlayerId(i)
                        if result then 
                            local name = sampGetPlayerNickname(i)
                            local isSelected = (script.selected_player_id == i)
                            
                            -- Cor baseada no HP (Verde se vivo, Vermelho se baixo)
                            local hp = sampGetPlayerHealth(i)
                            local color = hp > 50 and vu200.ImVec4(0.2, 1.0, 0.2, 1.0) or vu200.ImVec4(1.0, 0.2, 0.2, 1.0)
                            
                            vu200.PushStyleColor(vu200.Col.Text, color)
                            if vu200.Selectable("["..i.."] "..name.."##plt"..i, isSelected) then
                                script.selected_player_id = i
                            end
                            vu200.PopStyleColor(1)
                        end
                    end
                end
            vu200.EndChild()
            
            -- Bloco de Opções abaixo da lista
            vu200.Spacing()
            vu200.BeginChild("##ConfigJog", vu200.ImVec2(220, 65), true)
                vu200.Text(vu8.ICON_FA_COG .. " FILTROS")
                vu200.Separator()
                vu200.Text("Total: " .. (sampGetPlayerCount() or 0))
            vu200.EndChild()
        vu200.EndGroup()

        vu200.SameLine(nil, 12)

        -- 3. COLUNA DIREITA: AÇÕES DO JOGADOR
        vu200.BeginChild("##OpcoesJog", vu200.ImVec2(285, 315), true)
            vu200.Text(vu8.ICON_FA_USER_COG .. " ACOES")
            vu200.Separator()
            vu200.Spacing()

            if not script.selected_player_id or script.selected_player_id == -1 then
                vu200.TextWrapped("Selecione um jogador na lista ao lado para ver as acoes.")
            else
                local targetID = script.selected_player_id
                vu200.Text("SELECIONADO: " .. sampGetPlayerNickname(targetID) .. " ["..targetID.."]")
                vu200.Spacing()
                vu200.Separator()
                vu200.Spacing()

                -- Botão de Teleport
                if vu200.Button(vu8.ICON_FA_MAP_MARKER_ALT .. " IR ATE ELE", vu200.ImVec2(180, 30)) then
                    local result, charHandle = sampGetCharHandleBySampPlayerId(targetID)
                    if result and doesCharExist(charHandle) then
                        local x, y, z = getCharCoordinates(charHandle)
                        setCharCoordinates(PLAYER_PED, x, y, z)
                    end
                end

                vu200.Spacing()
                
                -- Botão de Explodir
                if vu200.Button(vu8.ICON_FA_BOMB .. " EXPLODIR", vu200.ImVec2(180, 30)) then
                    local res, x, y, z = sampGetPlayerPos(targetID)
                    if res then addExplosion(x, y, z, 12, 5.0) end
                end

                vu200.Spacing()

                -- Botão RIFA
                local btnLabel = rifaTargetActive and "PROCESSANDO..." or "RIFA 3 SEGUNDOS"
                if vu200.Button(vu8.ICON_FA_CAR .. " " .. btnLabel, vu200.ImVec2(180, 30)) then
                    if not rifaTargetActive then
                        rifaTargetActive = true
                        iniciarRifaNoAlvo(targetID)
                    end
                end

                vu200.Spacing()

                -- MUDANÇA: Botão EJETAR / APAGAR (Ação imediata)
                if vu200.Button(vu8.ICON_FA_TRASH .. " EJETAR / APAGAR", vu200.ImVec2(180, 30)) then
                    executarAtaqueEjetar(targetID)
                end
            end
        vu200.EndChild()
    vu200.EndGroup()
end
smallversiontext = nil
titlefont = nil
descfont = nil
inputfont = nil
connectfont = nil
chatinsertfont = nil
leftbar_size = nil
fontsize = nil
titlesize = nil
timefont = nil
TermFont = nil
AnswerFont = nil
QueFont = nil
ToggleButton_Font = nil
fa_size = nil
fa_font = nil
fa_glyph_ranges = vu200.ImGlyphRanges({
    vu8.min_range,
    vu8.max_range
})
function vu200.BeforeDrawFrame()
    if fa_font == nil then
        local v256 = vu200.ImFontConfig()
        v256.MergeMode = true
        fa_font = vu200.GetIO().Fonts:AddFontFromFileTTF("moonloader/resource/fonts/fa-solid-900.ttf", 13, v256, fa_glyph_ranges)
        vu200.GetIO().Fonts:GetGlyphRangesDefault()
        if fa_font == nil then
            local v257 = vu200.ImFontConfig()
            v257.MergeMode = true
            if doesFileExist(getWorkingDirectory() .. "/fonts/fontawesome-webfont.ttf") then
                fa_font = vu200.GetIO().Fonts:AddFontFromFileTTF(getWorkingDirectory() .. "/fonts/fontawesome-webfont.ttf", 14, v257, fa_glyph_ranges)
            else
                fa_font = vu200.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf", 14, v257, fa_glyph_ranges)
            end
        end
    end
    if fa_size == nil and doesFileExist(getWorkingDirectory() .. "/lib/fontawesome-webfont.ttf") then
        fa_size = vu200.GetIO().Fonts:AddFontFromFileTTF(getWorkingDirectory() .. "/lib/fontawesome-webfont.ttf", 32, nil, fa_glyph_ranges)
    end
    if leftbar_size == nil then
        leftbar_size = vu200.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf", 31, nil, vu200.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
    if fontsize == nil then
        fontsize = vu200.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf", 19.5, nil, vu200.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
    if titlesize == nil then
        titlesize = vu200.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf", 30, nil, vu200.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
    if timefont == nil then
        timefont = vu200.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf", 17, nil, vu200.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
    if QueFont == nil then
        QueFont = vu200.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf", 18, nil, vu200.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
    if TermFont == nil then
        TermFont = vu200.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf", 16, nil, vu200.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
    if AnswerFont == nil then
        AnswerFont = vu200.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf", 14, nil, vu200.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
    if ToggleButton_Font == nil then
        ToggleButton_Font = vu200.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf", 15.5, nil, vu200.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
    if titlefont == nil then
        titlefont = vu200.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf", 35, nil, vu200.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
    if smallversiontext == nil then
        smallversiontext = vu200.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf", 12, nil, vu200.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
    if descfont == nil then
        descfont = vu200.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf", 16.5, nil, vu200.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
    if inputfont == nil then
        inputfont = vu200.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf", 47, nil, vu200.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
    if connectfont == nil then
        connectfont = vu200.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf", 30, nil, vu200.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
    if chatinsertfont == nil then
        chatinsertfont = vu200.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf", 17, nil, vu200.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
end
function vu200.OnDrawFrame()
    local v258, v259 = getScreenResolution()
    if script.window.v or script.sms_window.v then
        if script.iHUD.v then
            vu200.ShowCursor = true
        end
        if script.vHUD.v then
            vu200.ShowCursor = true
        end
        if script.cHUD.v then
            vu200.ShowCursor = true
        end
        if script.StaminaHUD.v then
            vu200.ShowCursor = true
        end
        if script.admin_panel.v then
            vu200.ShowCursor = true
        end
    else
        vu200.ShowCursor = false
    end
    if script.admin_panel.v then
        vu200.SetNextWindowPos(vu200.ImVec2(v258 - vu200.GetStyle().ItemSpacing.x, v259 - vu200.GetStyle().ItemSpacing.x), vu200.Cond.FirstUseEver, vu200.ImVec2(1, 1))
        vu200.SetNextWindowSize(vu200.ImVec2(350, 450), vu200.Cond.FirstUseEver)
        vu200.PushStyleColor(vu200.Col.WindowBg, vu200.ImVec4(0, 0, 0, 0.5))
        vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0, 0, 0, 1))
        vu200.Begin("##admin_tool", nil, 167)
        vu200.CenterText("")
        vu200.End()
        vu200.PopStyleColor(2)
    end
    if version_status ~= "checking..." then
        if version_status == "uptodate" and script.window.v then
            local _ = script.Skin_Editor
            if script.SettingsLEFT then
                vu200.SetNextWindowPos(vu200.ImVec2(0, 0), vu200.Cond.FirstUseEver, vu200.ImVec2(0, 0))
                vu200.SetNextWindowSize(vu200.ImVec2(v258, v259), vu200.Cond.FirstUseEver)
                vu200.PushStyleVar(vu200.StyleVar.WindowRounding, 0)
                vu200.PushStyleColor(vu200.Col.WindowBg, vu200.ImVec4(0, 0, 0, 0.5))
                vu200.PushStyleColor(vu200.Col.Border, vu200.ImVec4(0, 0, 0, 0))
                vu200.Begin("##settings_leftbar", script.window, 167)
                vu200.SetCursorPosX(vu200.GetWindowSize().x - (350 + vu200.GetStyle().ItemSpacing.y))
                vu200.PushStyleColor(vu200.Col.Border, vu200.ImVec4(0.89, 0.85, 0.92, 0.3))
                vu200.BeginChild("##setings", vu200.ImVec2(350, 126), true)
                vu200.Text("")
                vu200.SameLine(7)
                vu200.PushFont(fa_size)
                vu200.Text(vu8.ICON_FA_COG)
                vu200.PopFont()
                vu200.SameLine()
                vu200.PushFont(leftbar_size)
                vu200.Text("SETTINGS")
                vu200.PopFont()
                vu200.SameLine(vu200.GetWindowSize().x - (30 + vu200.GetStyle().ItemSpacing.y + 2))
                vu200.SetCursorPosY(vu200.GetStyle().ItemSpacing.y + 2)
                vu200.BeginGroup()
                vu200.PushStyleVar(vu200.StyleVar.FrameRounding, 50)
                vu200.PushStyleColor(vu200.Col.Border, vu200.ImVec4(0, 0, 0, 0))
                vu200.PushStyleColor(vu200.Col.Button, vu200.ImVec4(0.2, 0.2, 0.2, 0.5))
                vu200.PushStyleColor(vu200.Col.ButtonHovered, vu200.ImVec4(0.98, 0.26, 0.26, 1))
                vu200.PushStyleColor(vu200.Col.ButtonActive, vu200.ImVec4(0.98, 0.26, 0.26, 0.4))
                if vu200.Button("  " .. vu8.ICON_FA_TIMES, vu200.ImVec2(30, 30)) then
                    script.SettingsLEFT = not script.SettingsLEFT
                end
                vu200.PopStyleColor(4)
                vu200.PopStyleVar()
                vu200.EndGroup()
                vu200.CustomSeparator(height, width)
                if vu200.Button(vu8.ICON_FA_SAVE .. " Save current settings", vu200.ImVec2(- 0.1, 0)) then
                    settings_ini_save()
                end
                if vu200.Button(vu8.ICON_FA_RETWEET .. " Load last saved settings", vu200.ImVec2(- 0.1, 0)) then
                    settings_ini_load()
                end
                vu200.Separator()
                if vu200.Combo("Active key", script.activekey, {
                    "INSERT",
                    "DELETE",
                    "HOME",
                    "END"
                }) then
                    ini.functions.activekey = script.activekey.v
                    inicfg.save(ini, MainSettingsdirectIni)
                end
                vu200.EndChild()
                vu200.PopStyleColor()
                vu200.End()
                vu200.PopStyleColor(2)
                vu200.PopStyleVar()
            end
           if ini.license.Agree ~= false then
    musiclist = getMusicList()
    vu200.SetNextWindowPos(vu200.ImVec2(v258 / 2, v259 / 2), vu200.Cond.FirstUseEver, vu200.ImVec2(0.5, 0.5))
    vu200.SetNextWindowSize(vu200.ImVec2(596, 520), vu200.Cond.FirstUseEver)
    WindowBg()
    vu200.Begin("##main_menu", script.window, 2211)
    -- Desenha a janela de lista aqui para garantir renderização no mesmo frame do menu
    desenhar_janela_lista()
    
    -- Cor da borda (mesma da sua coluna lateral)
    vu200.PushStyleColor(vu200.Col.Border, vu200.ImVec4(0.89, 0.85, 0.92, 0.3))
    
    vu200.BeginGroup()
    
-- ########## ÁREA DE AJUSTE MANUAL ##########
local largura_logo_box = 149  -- Ajusta o fim do bloco da logo (Lado esquerdo da fenda)
local inicio_texto_box = 155  -- Ajusta o início do bloco do nome (Lado direito da fenda)
-- ############################################

vu200.BeginGroup() 

    -- 1. BLOCO DA ESQUERDA (LOGO)
    -- Usamos a variável 'largura_logo_box' para definir o limite
    vu200.BeginChild("##header_left", vu200.ImVec2(largura_logo_box, 110), false, 62)
        if script.menulogo ~= nil then
            local logo_size = 135
            
            -- AJUSTE DE ALTURA DA LOGO AQUI:
            -- O segundo número (atualmente -5) move para cima ou para baixo
            -- Como a logo (125) é maior que o espaço (110), use valores negativos para subir
            vu200.SetCursorPos(vu200.ImVec2((largura_logo_box - logo_size) / 2, -10)) 
            
            -- ImVec4(1,1,1,1) no final evita que a logo fique branca
            vu200.Image(script.menulogo, vu200.ImVec2(logo_size, logo_size), vu200.ImVec2(0,0), vu200.ImVec2(1,1), vu200.ImVec4(1,1,1,1))
        end
    vu200.EndChild()

    -- 2. O VÃO TRANSPARENTE
    vu200.SameLine(inicio_texto_box) 

    -- 3. BLOCO DA DIREITA (TÍTULO E BOTÕES)
    -- Usamos a flag 14 para não ter scroll, mas permitir cliques nos botões de fechar
    vu200.BeginChild("##header_right", vu200.ImVec2(0, 110), false, 14)
        local white_text = vu200.ImVec4(1.0, 1.0, 1.0, 1.0)

        -- AJUSTE DE ALTURA E POSIÇÃO DO TEXTO AQUI:
        vu200.SetCursorPosY(45) -- Ajuste este valor para subir ou descer o nome do menu
        vu200.SetCursorPosX(20) -- Ajuste este valor para afastar o texto da fenda
        
        vu200.PushFont(fontsize)
        vu200.TextColored(white_text, "ARABE MENU")
        vu200.PopFont()

        -- BOTÕES DE FECHAR E CONFIG
        -- SameLine relativo ao final da janela para não sumir
        vu200.SameLine(vu200.GetContentRegionAvailWidth() - 55) 
        vu200.SetCursorPosY(10)
        
        if vu200.Button(" " .. vu8.ICON_FA_COG, vu200.ImVec2(22, 22)) then
            script.SettingsLEFT = not script.SettingsLEFT
        end
        vu200.SameLine()
        vu200.PushStyleColor(vu200.Col.Button, vu200.ImVec4(0.98, 0.06, 0.06, 1.0))
        if vu200.Button(" " .. vu8.ICON_FA_TIMES, vu200.ImVec2(22, 22)) then
            script.window.v = not script.window.v
        end
        vu200.PopStyleColor()
    vu200.EndChild()

vu200.EndGroup()
    -- ########## COLUNA LATERAL (CATEGORIAS) ##########
    menu_btn = vu200.ImVec2(140, 28)
vu200.PushStyleVar(vu200.StyleVar.ButtonTextAlign, vu200.ImVec2(0.5, 0.5))

-- 1. Deixamos o fundo da coluna transparente
vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0, 0, 0, 0))

-- 2. Mudamos o 'true' para 'false' para remover a borda branca da lateral
vu200.BeginChild("##left-navigation", vu200.ImVec2(menu_btn.x + vu200.GetStyle().FramePadding.x * 2 + 4, 0), false)
    vu200.SetCursorPosY(3)

    -- 3. Deixamos o fundo dos botões invisível (Transparência total)
    vu200.PushStyleColor(vu200.Col.Button, vu200.ImVec4(0, 0, 0, 0))
    
    -- Cor de quando você passa o mouse (um azul bem leve para combinar)
    vu200.PushStyleColor(vu200.Col.ButtonHovered, vu200.ImVec4(0.0, 0.47, 0.84, 0.2))
    
    -- Cor de quando o botão está selecionado (Azul do Lucas Menu)
    vu200.PushStyleColor(vu200.Col.ButtonActive, vu200.ImVec4(0.0, 0.47, 0.84, 0.4))

    -- Botões das Categorias
    if script.page ~= 1 then vu200.LeftButton(" " .. vu8.ICON_FA_USER .. "  JOGADOR", menu_btn, 1) else vu200.LeftButtonHovered(" " .. vu8.ICON_FA_USER .. "  JOGADOR", menu_btn) end
    if script.page ~= 3 then vu200.LeftButton(" " .. vu8.ICON_FA_CROSSHAIRS .. "  AIMBOT", menu_btn, 3) else vu200.LeftButtonHovered(" " .. vu8.ICON_FA_CROSSHAIRS .. "  AIMBOT", menu_btn) end
    if script.page ~= 4 then vu200.LeftButton(" " .. vu8.ICON_FA_CAR .. "  VEICULOS", menu_btn, 4) else vu200.LeftButtonHovered(" " .. vu8.ICON_FA_CAR .. "  VEICULOS", menu_btn) end
    if script.page ~= 5 then vu200.LeftButton(" " .. vu8.ICON_FA_EYE .. "  VISUAIS", menu_btn, 5) else vu200.LeftButtonHovered(" " .. vu8.ICON_FA_EYE .. "  VISUAIS", menu_btn) end
    if script.page ~= 6 then vu200.LeftButton(" " .. vu8.ICON_FA_MAP_MARKER .. "  TELEPORT", menu_btn, 6) else vu200.LeftButtonHovered(" " .. vu8.ICON_FA_MAP_MARKER .. "  TELEPORT", menu_btn) end
    if script.page ~= 2 then vu200.LeftButton(" " .. vu8.ICON_FA_DATABASE .. "  CONFIG", menu_btn, 2) else vu200.LeftButtonHovered(" " .. vu8.ICON_FA_DATABASE .. "  CONFIG", menu_btn) end
    if script.page ~= 10 then vu200.LeftButton(" " .. vu8.ICON_FA_USERS .. "  ONLINE", menu_btn, 10) else vu200.LeftButtonHovered(" " .. vu8.ICON_FA_USERS .. "  ONLINE", menu_btn) end
    if script.page ~= 11 then vu200.LeftButton(" " .. vu8.ICON_FA_BOMB .. "  BYPASS", menu_btn, 11) else vu200.LeftButtonHovered(" " .. vu8.ICON_FA_BOMB .. "  BYPASS", menu_btn) end
    if script.page ~= 7 then vu200.LeftButton(" " .. vu8.ICON_FA_GAMEPAD .. "  GAME", menu_btn, 7) else vu200.LeftButtonHovered(" " .. vu8.ICON_FA_GAMEPAD .. "  GAME", menu_btn) end
    if script.page ~= 8 then vu200.LeftButton(" " .. vu8.ICON_FA_INFO_CIRCLE .. "  Credits", menu_btn, 8) else vu200.LeftButtonHovered(" " .. vu8.ICON_FA_INFO_CIRCLE .. "  Credits", menu_btn) end
                vu200.PopStyleColor(3)
                vu200.EndChild()
                vu200.PopStyleColor(1)
                vu200.PopStyleVar()
                vu200.SameLine()
                vu200.BeginGroup()
                vu200.BeginChild("##right-options##GGgo!!!", vu200.ImVec2(0, 0), true)
                if script.page == 1 then
                    vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0.02, 0.04, 0.08, 1.0))
                    vu200.BeginChild("##header_player", vu200.ImVec2(0, 60), true)
                    if vu200.Button(" " .. vu8.ICON_FA_SKULL .. " Suicide", vu200.ImVec2((vu200.GetWindowWidth() - 26) / 2, 24)) then
                        setCharHealth(PLAYER_PED, 0)
                    end
                    vu200.SameLine()
                    if vu200.Button(" " .. vu8.ICON_FA_SYNC .. " Respawn", vu200.ImVec2((vu200.GetWindowWidth() - 4) / 2, 24)) then
                        sampSpawnPlayer()
                    end
                    if vu200.Button(" " .. vu8.ICON_FA_HEART .. " Reset Healh", vu200.ImVec2((vu200.GetWindowWidth() - 26) / 2, 24)) then
                        if GG_OVERHP.v then
                            setCharHealth(PLAYER_PED, 160)
                        else
                            setCharHealth(PLAYER_PED, 100)
                        end
                    end
                    vu200.SameLine()
                    if getCharArmour(PLAYER_PED) <= 1 then
                        if vu200.Button(" " .. vu8.ICON_FA_SHIELD_ALT .. " Get Armour", vu200.ImVec2((vu200.GetWindowWidth() - 4) / 2, 24)) then
                            addArmourToChar(playerPed, 100)
                        end
                    elseif vu200.Button(" " .. vu8.ICON_FA_SHIELD_ALT .. " Reset Armour", vu200.ImVec2((vu200.GetWindowWidth() - 4) / 2, 24)) then
                        addArmourToChar(playerPed, 100)
                    end
                    vu200.EndChild()
                    vu200.BeginChild("##playerpage1", vu200.ImVec2(204, 320), false)
                    vu200.CheckboxRight("GodMode", "God Mode", 180, GG_GM)
                    vu200.ToggleButton("toggle1##2", "No Fall ", 175, GG_NoFall)
                    vu200.ToggleButton("toggle1##rotation", "Fast Rotation ", 175, GG_FastRotation)
                    vu200.ToggleButton("toggle1##3", "AutoRun", 175, GG_autorun)
                    vu200.ToggleButton("toggle1##4", "Infinity Run", 175, GG_InfinityRun)
                    vu200.ToggleButton("toggle1##5", "Mega Jump", 175, GG_MegaJump)
                    vu200.ToggleButton("toggle1##6", "Anti Stun", 175, GG_AntiStun)
                    vu200.ToggleButton("toggle1##7", "Fugga", 175, GG_Fugga)
                    vu200.ToggleButton("toggle1##8", "Anti Afk", 175, GG_AntiAfk)
                    vu200.ToggleButton("toggle1##inf02", "Infinity Oxygen", 175, GG_InfO2)
                    vu200.ToggleButton("toggle1##9", "Invisible [OnFoot]", 175, GG_Invisible)
                    vu200.Checkbox("Rvanka", GG_rvanka)
                    vu200.Checkbox("Invert Mode", GG_InvertPlayer2021)
                    vu200.Checkbox("Crazy Mode", GG_CrazyPlayer2021)
                    vu200.EndChild()
                    vu200.SameLine()
                    vu200.BeginChild("##playerpage2", vu200.ImVec2(0, 320), false)
                    vu200.Checkbox("Fast Walk", GG_FastWalk)
                    vu200.SliderInt("run speed", script.fastwalk, 1, 10)
                    vu200.Separator()
                    vu200.Checkbox(u8"airbreak", GG_AirBreak)
                    vu200.SameLine()
                    vu200.Text(vu8.ICON_FA_COG)
                    if vu200.IsItemClicked(0) or vu200.IsItemClicked(1) then
                    vu200.OpenPopup("velocity_popup")
                    end
                    if vu200.BeginPopup("velocity_popup") then
                        vu200.Text("AirBreak settings")
                        vu200.SliderFloat("AirBreak Speed", script.AirBreakSpeed, 0.1, 5.0, "%.2f")
                        vu200.Separator()
                        vu200.EndPopup()
                    end
                    vu200.EndChild()
                    vu200.PopStyleColor(1)
                end
                if script.page == 2 then
                    vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0.02, 0.04, 0.08, 1.0))
                    vu200.BeginChild("##raknetpage1", vu200.ImVec2(109, 0), true)
                    vu200.PushStyleColor(vu200.Col.Button, vu200.ImVec4(0.98, 0.06, 0.06, 1))
                    vu200.PushStyleColor(vu200.Col.ButtonHovered, vu200.ImVec4(0.98, 0.26, 0.26, 1))
                    vu200.PushStyleColor(vu200.Col.ButtonActive, vu200.ImVec4(0.98, 0.26, 0.26, 0.4))
                    vu200.PushStyleVar(vu200.StyleVar.ButtonTextAlign, vu200.ImVec2(0.5, 0.5))
                    if vu200.Button("CLEAN TASK", vu200.ImVec2(- 0.1, 0)) then
                        sampSetSpecialAction(0)
                        clearCharTasksImmediately(PLAYER_PED)
                    end
                    vu200.PopStyleVar()
                    vu200.PopStyleColor(3)
                    vu200.Separator()
                    local v273, v274, v275 = pairs(sampanim)
                    while true do
                        local v276
                        v275, v276 = v273(v274, v275)
                        if v275 == nil then
                            break
                        end
                        anim_id = v276:match("([^, ]+)")
                        show_anim(v275, anim_id)
                    end
                    vu200.EndChild()
                    vu200.SameLine()
                    vu200.BeginChild("##raknetpage2", vu200.ImVec2(0, 0), true)
                    vu200.Text("NOTE: Use \'Fake_Spawn\' before login/register")
                    vu200.Separator()
                    vu200.PushStyleColor(vu200.Col.Button, vu200.ImVec4(0.26, 0.59, 0.98, 0.35))
                    vu200.PushStyleColor(vu200.Col.ButtonHovered, vu200.ImVec4(0.26, 0.59, 0.98, 1))
                    vu200.PushStyleColor(vu200.Col.ButtonActive, vu200.ImVec4(0.06, 0.53, 0.98, 1))
                    if vu200.Button("Fake_Spawn", vu200.ImVec2(- 0.1, 0)) then
                        fake_spawn()
                    end
                    vu200.PopStyleColor(3)
                    vu200.Hint("Use this button before login/register")
                    vu200.Separator()
                    if script.bypass ~= false then
                        vu200.PushStyleColor(vu200.Col.Button, vu200.ImVec4(0.98, 0.26, 0.26, 0.4))
                        vu200.PushStyleColor(vu200.Col.ButtonHovered, vu200.ImVec4(0.98, 0.26, 0.26, 1))
                        vu200.PushStyleColor(vu200.Col.ButtonActive, vu200.ImVec4(0.98, 0.06, 0.06, 1))
                        if vu200.Button("Turn ByPass OFF", vu200.ImVec2(- 0.1, 0)) then
                            script.bypass = false
                        end
                        vu200.PopStyleColor(3)
                    else
                        vu200.PushStyleColor(vu200.Col.Button, vu200.ImVec4(0.26, 0.98, 0.85, 0.4))
                        vu200.PushStyleColor(vu200.Col.ButtonHovered, vu200.ImVec4(0.26, 0.98, 0.85, 1))
                        vu200.PushStyleColor(vu200.Col.ButtonActive, vu200.ImVec4(0.06, 0.98, 0.82, 1))
                        if vu200.Button("Turn ByPass ON", vu200.ImVec2(- 0.1, 0)) then
                            script.bypass = true
                        end
                        vu200.PopStyleColor(3)
                    end
                    vu200.Separator()
                    if vu200.CollapsingHeader("SAMP Advanced") then
                        vu200.Checkbox("Block SAMP Collision", GG_ObjectCollision)
                        vu200.Checkbox("Block Drug Effect", GG_BlockDrugsAnimation)
                        vu200.Checkbox("Set Max Health to 160HP", GG_OVERHP)
                        vu200.Checkbox("RP Name tag", GG_RPName)
                        vu200.HintTooltip("Remove the \'_\' from the player\'s name \n{ff0000}Note: {ffffff}require for restart after disable")
                    end
                    vu200.BeginChild("nops patch", vu200.ImVec2(0, 0), true)
                    if vu200.Button(" Incoming RPC ") then
                        script.nops_page = 1
                    end
                    vu200.SameLine()
                    if vu200.Button(" Outcoming RPC ") then
                        script.nops_page = 4
                    end
                    vu200.SameLine()
                    if vu200.Button("Incoming Packets") then
                        script.nops_page = 3
                    end
                    vu200.SameLine()
                    if vu200.Button("Outcoming Packets") then
                        script.nops_page = 2
                    end
                    vu200.Separator()
                    vu200.InputText("filter", script.nops_filter)
                    vu200.BeginChild("nops_patch_list", vu200.ImVec2(0, 0), true)
                    render_nops_filter(1, vu196, script.nops_filter)
                    render_nops_filter(2, vu195, script.nops_filter)
                    render_nops_filter(3, vu193, script.nops_filter)
                    render_nops_filter(4, vu192, script.nops_filter)
                    vu200.EndChild()
                    vu200.EndChild()
                    vu200.EndChild()
                    vu200.PopStyleColor(1)
                end
                if script.page == 3 then
                    vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0.02, 0.04, 0.08, 1.0))
                    vu200.BeginChild("##weaponspage1", vu200.ImVec2(200, 0), false)
                    if vu200.Button(vu8.ICON_FA_TRASH .. " Remove All Weapons", vu200.ImVec2((vu200.GetWindowWidth() - 8) / 1, 23)) then
                        removeAllCharWeapons(PLAYER_PED)
                    end
                    current_weapon_name = vu7.get_name(getCurrentCharWeapon(PLAYER_PED))
                    if current_weapon_name == nil then
                        current_weapon_name = "Unknow"
                    end
                    if vu200.Button(vu8.ICON_FA_TRASH .. " Remove Current Weapon (" .. current_weapon_name .. ")", vu200.ImVec2((vu200.GetWindowWidth() - 8) / 1, 23)) then
                        removeWeaponFromChar(PLAYER_PED, getCurrentCharWeapon(PLAYER_PED))
                    end
                    vu200.Separator()
                    vu200.PushStyleVar(vu200.StyleVar.ChildWindowRounding, 0)
                    vu200.BeginChild("aimfunctions xD", vu200.ImVec2(0, 150), false)
                    vu200.ToggleButton("toggle2##camrestor", "No Cam Restore", 150, GG_noCamRestore)
                    vu200.ToggleButton("toggle2##1", "Infinity Ammo", 150, GG_InfinityAmmo)
                    vu200.ToggleButton("toggle2##2", "Full Skills", 150, GG_FullSkills)
                    vu200.ToggleButton("toggle2##3", "No Reload", 150, GG_NoReload)
                    vu200.ToggleButton("toggle2##4", "Bell Sound", 150, GG_bell)
                    vu200.ToggleButton("toggle2##6", "No Spread", 150, GG_NoSpread)
                    vu200.ToggleButton("toggle2##7", "SensFix", 150, GG_SensFix)
                    vu200.ToggleButton("toggle2##12", "GTA V Aim System", 150, GG_gtavaim)
                    vu200.EndChild()
                    vu200.PopStyleVar()
                    vu200.Separator()
                    vu200.Checkbox("Cbug", GG_Cbug)
                    vu200.SameLine()
                    if vu200.Button(" " .. vu8.ICON_FA_COG .. " Settings##cbug") then
                        vu200.OpenPopup("cbug")
                    end
                    if vu200.BeginPopup("cbug") then
                        vu200.RadioButton("+C Helper ", script.radio_cbug, 0)
                        vu200.RadioButton("Auto +C ", script.radio_cbug, 1)
                        vu200.RadioButton("Rapid +C ", script.radio_cbug, 2)
                        vu200.EndPopup()
                    end
                    vu200.Checkbox("TriggerBot", GG_trigger)
                    vu200.Checkbox("AimBot", GG_AimBot)
                    vu200.SameLine()
                    if vu200.Button(" " .. vu8.ICON_FA_COG .. " Settings##AB") then
                        vu200.OpenPopup("aimbotsettings")
                    end
                    if vu200.BeginPopup("aimbotsettings") then
                        vu200.Text("Type:")
                        vu200.RadioButton("Normal AimBot ", script.aimbot_type, 0)
                        vu200.RadioButton("Pro AimBot ", script.aimbot_type, 1)
                        vu200.RadioButton("Smooth AimBot ", script.aimbot_type, 2)
                        vu200.Text("Config:")
                        if script.aimbot_type.v ~= 0 then
                            if script.aimbot_type.v ~= 1 then
                                vu200.Checkbox("Skip Dead (smoothaim) ##smoothaim", aimbot.skipDead)
                                vu200.Checkbox("Don\'t aim while playing animations ##smoothaim", aimbot.disabledOnAnim)
                                vu200.Checkbox("Doesn\'t target if clist is equal to your ##smoothaim", aimbot.disabledIfFriend)
                                vu200.Checkbox("Don`t aim while player is AFK ##smoothaim", aimbot.disabledOnAFk)
                                vu200.SliderFloat("Smooth aiming", aimbot.smoothSpeed, 1, 30, "%.1f")
                                vu200.SliderFloat("Increase the smoothness of the aiming", aimbot.addSmoothSpeed, 1, 30, "%.1f")
                            else
                                vu200.Checkbox("Skip Dead ##proaim", aimbot.proSkipDead)
                                vu200.SliderFloat("The area from the crosshair, in which the search for the enemy will be ignored", aimbot.safeZone, 1, 300, "%.1f")
                                vu200.SliderFloat("The maximum distance from the scope at which the enemy will be found", aimbot.jobRadius, 1, 300, "%.1f")
                            end
                        else
                            vu200.Checkbox("Ignore players with my color ##aimbot", aimbot.team_ignore)
                        end
                        vu200.EndPopup()
                    end
                    if vu200.Checkbox("SilentAim", imgClickInfState) then
                        tarPed = - 1
                    end
                    vu200.SameLine()
                    vu200.Text(vu8.ICON_FA_COG)
                        if vu200.IsItemClicked() then
                        vu200.OpenPopup("silentsettings")
                    end
                    if vu200.BeginPopup("silentsettings") then
                        vu200.Text("Body parts:")
                        if vu200.Checkbox(u8("Head "), imgClickinfHead) then
                            DisableAllBody(false, false, true)
                        end
                        if vu200.Checkbox(u8("Torso"), imgClickinfTorso) then
                            DisableAllBody(true, false, false)
                        end
                        if vu200.Checkbox(u8("Groin"), imgClickinfGroin) then
                            DisableAllBody(false, true, false)
                        end
                        vu200.Text("dist:")
                        vu200.SliderFloat("Fov", imgSliderInfFov, 0, 80)
                        vu200.SliderFloat("Hit", imgSliderInfRand, 0, 100)
                        vu200.Text("Config:")
                        vu200.Checkbox(u8("Ignore objects "), imgClickInfObj)
                        vu200.Checkbox(u8("Ignore transport "), imgClickInfVeh)
                        vu200.Checkbox(u8("Ignore players with my color "), imgClickinfClist)
                        vu200.Checkbox(u8("Draw lines"), imgClickInfLine)
                        vu200.SliderFloat(u8("Blood Density "), imgSliderInfBlood, 0, 100)
                        vu200.EndPopup()
                    end
                    vu200.EndChild()
                    vu200.SameLine()
                    vu200.BeginChild("##weaponspage2", vu200.ImVec2(0, 0), true)
                    vu200.ToggleButton("toggle2##10", "Send damage", 210, GG_damager)
                    vu200.ToggleButton("toggle2##11", "Minigun damager", 210, GG_cdamage)
                    vu200.Separator()
                    vu200.Checkbox("Rapid Fire", GG_Rapid)
                    vu200.SliderInt("Rapid Speed", script.RapidSpeed, 1, 15)
                    vu200.BeginChild("##weaponspage3", vu200.ImVec2(0, 0), true)
                    vu200.PushStyleVar(vu200.StyleVar.ButtonTextAlign, vu200.ImVec2(0.5, 0.5))
                    vu200.InputInt("Ammo", script.weapon_ammo, 1, 10, 0)
                    vu200.PopStyleVar()
                    ret = 0
                    local v277, v278, v279 = ipairs(weapons_pictures)
                    while true do
                        local v280
                        v279, v280 = v277(v278, v279)
                        if v279 == nil then
                            break
                        end
                        if vu200.ImageButton(v280.tex, vu200.ImVec2(25, 25), vu200.ImVec2(0, 0), vu200.ImVec2(1, 1), 3, vu200.ImVec4(0, 0, 0, 0), vu200.ImVec4(1, 1, 1, 1)) and v280.id then
                            give_weapon_to_char(PLAYER_PED, v280.id, script.weapon_ammo.v)
                        end
                        ret = ret + 1
                        if ret > 6 then
                            ret = 0
                        else
                            vu200.SameLine()
                        end
                    end
                    vu200.EndChild()
                    vu200.EndChild()
                    vu200.PopStyleColor(1)
                end
                if script.page == 4 then
                    vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0.02, 0.04, 0.08, 1.0))
                    vu200.BeginChild("##vehiclepage1", vu200.ImVec2(200, 0), true)
                    vu200.ToggleButton("toggle4##1", "GodMode Car", 170, GG_GMCar)
                    vu200.ToggleButton("toggle4##wheels", "GodMode Wheels", 170, GG_GMWheels)
                    vu200.ToggleButton("toggle4##2", "No Fall Of Bike", 170, GG_Fbike)
                    vu200.ToggleButton("toggle4##3", "Flood Comp", 170, GG_FC)
                    vu200.ToggleButton("toggle4##4", "Tank Mode", 170, GG_Tmode)
                    vu200.ToggleButton("toggle4##5", "Infinity Fuel", 170, GG_InfinityFuel)
                    vu200.ToggleButton("toggle4##6", "No Radio", 170, GG_NoRadio)
                    vu200.ToggleButton("toggle4##7", "Rid on wather", 170, GG_Water)
                    vu200.ToggleButton("toggle4##underwater", "Drive Under Water", 170, GG_driveUnderWater)
                    vu200.ToggleButton("toggle4##8", "Car Shot", 170, GG_CarShot)
                    vu200.ToggleButton("toggle4##9", "High BMX jump", 170, GG_bmx)
                    vu200.ToggleButton("toggle4##10", "Nitro Mode (press Num0)", 170, GG_Nitro)
                    vu200.ToggleButton("toggle4##11", "dirigir sem licenca", 170, GG_dirigirsemlicenca)
                    vu200.ToggleButton("toggle4##15", "destrancar", 170, GG_destrancar)
                    vu200.Checkbox(u8"Bloquear RPC", GG_bloquearrpc)
                    vu200.SameLine()
                    vu200.Text(vu8.ICON_FA_COG)
                    if vu200.IsItemClicked(0) or vu200.IsItemClicked(1) then
                    vu200.OpenPopup("bloquear_popup")
                    end
                    if vu200.BeginPopup("bloquear_popup") then
                    vu200.Checkbox("Anti Cam Pos", GG_AntiCamPos)
                    vu200.Checkbox("Anti Clear Anim", GG_AntiAnimClear)
                    vu200.Checkbox("Anti Freeze", GG_AntiFreeze)
                    vu200.Checkbox("Anti Dialog", GG_AntiDialog)
                    vu200.EndPopup()
                    end

                    vu200.Separator()
                    vu200.PushStyleVar(vu200.StyleVar.ButtonTextAlign, vu200.ImVec2(0.5, 0.4))
                    if vu200.Button("Explode your Vehicle", vu200.ImVec2((vu200.GetWindowWidth() - 13) / 2, 20)) and isCharInAnyCar(PLAYER_PED) then
                        veh = storeCarCharIsInNoSave(PLAYER_PED)
                        setCarHealth(veh, 1)
                    end
                    vu200.SameLine()
                    if vu200.Button("Repair vehicle", vu200.ImVec2((vu200.GetWindowWidth() - 13) / 2, 20)) and isCharInAnyCar(PLAYER_PED) then
                        veh = storeCarCharIsInNoSave(PLAYER_PED)
                        setCarHealth(veh, 10000000)
                    end
                    if vu200.Button("Add Hydraulics", vu200.ImVec2((vu200.GetWindowWidth() - 13) / 2, 20)) and isCharInAnyCar(PLAYER_PED) then
                        veh = storeCarCharIsInNoSave(PLAYER_PED)
                        setCarHydraulics(veh, true)
                    end
                    vu200.SameLine()
                    if vu200.Button("Remove Hydraulics", vu200.ImVec2((vu200.GetWindowWidth() - 13) / 2, 20)) and isCharInAnyCar(PLAYER_PED) then
                        veh = storeCarCharIsInNoSave(PLAYER_PED)
                        setCarHydraulics(veh, false)
                    end
                    vu200.PopStyleVar()
                    vu200.EndChild()
                    vu200.SameLine()
                    vu200.BeginChild("##vehiclepage2", vu200.ImVec2(0, 0), true)
                    vu200.Checkbox("Car Jump (press left shift)", GG_CarJump)
                    vu200.SliderFloat("jump length", script.lengthJump, 0.1, 1.5)
                    vu200.Separator()
                    vu200.Checkbox("SpeedHack (press ALT)", GG_altspeed)
                    vu200.SameLine()
                    vu200.HintTooltipQuestion(u8("Speeds up your car."))
                    vu200.SliderInt("Max speed", script.altspeedhack, 100, 800)
                    vu200.Separator()
                    vu200.ToggleButton("toggle4##drift", "Drift Mode (press left ctrl)", 230, GG_driftInCar)
                    vu200.Separator()
                    vu200.ToggleButton("toggle4##12", "Invert Mode Veh", 190, GG_InvertVeh2021)
                    vu200.ToggleButton("toggle4##13", "Crazy Mode Veh", 190, GG_CrazyVeh2021)
                    vu200.ToggleButton("toggle4##15", "RIFA DO BUZEIRA", 190, GG_rifadobuzeira)
                    vu200.ToggleButton("toggle4##16", "GRUDAR EXPLODIR", 190, GG_grudarexplodir)
                    vu200.ToggleButton("toggle4##19", "TELAGEM", 190, GG_telagem)
                    if GG_telagem.v ~= __GG_telagem_last then
                        __GG_telagem_last = GG_telagem.v
                        if not GG_telagem.v then
                            stopTv()
                        end
                    end
                    vu200.ToggleButton("toggle4##20", "PARAR JOGADORES", 190, GG_pararjogadores)
                    vu200.Separator()
                    if vu200.CollapsingHeader("Unlock any vehicle !") then
                        vu200.Text("NOTE:Type /dl in the chat to see vehicle IDs")
                        vu200.Separator()
                        vu200.InputText("vehicle\'s ID", script.unlock_carID, 1)
                        if vu200.Button(vu8.ICON_FA_UNLOCK .. " Unlock") then
                            openVehicle(script.unlock_carID.v)
                        end
                        vu200.Separator()
                    end
                    if vu200.CollapsingHeader("Vehicles troll") then
                        vu200.Text("     ")
                        vu200.SameLine()
                        vu200.BeginGroup()
                        vu200.Text("NOTE: Type /dl in the chat to see vehicle \nIDs")
                        vu200.Separator()
                        if vu200.CollapsingHeader("Warp to vehicle by ID") then
                            vu200.PushItemWidth(150)
                            vu200.InputText("vehicle ID##warpto", script.warp_carID, 1)
                            if vu200.Button("Warp to vehicle##lol", vu200.ImVec2(- 0.1, 0)) then
                                WarpToVehicle(script.warp_carID.v)
                            end
                            vu200.Separator()
                        end
                        if vu200.CollapsingHeader("Warp vehicle to you by ID") then
                            vu200.PushItemWidth(150)
                            vu200.InputText("vehicle ID##getvehicle", script.get_carID, 1)
                            if vu200.Button("Warp vehicle to you##lol", vu200.ImVec2(- 0.1, 0)) then
                                GetVehicle(script.get_carID.v)
                            end
                            vu200.Separator()
                        end
                        if vu200.CollapsingHeader("explode vehicle") then
                            vu200.Text("WARN: {Use on empty vehicles")
                            vu200.Separator()
                            vu200.PushItemWidth(150)
                            vu200.InputText("vehicle ID##explode", script.explode_carID, 1)
                            if vu200.Button("Explode vehicle", vu200.ImVec2(- 0.1, 0)) then
                                ExplodeVehicle(script.explode_carID.v)
                            end
                        end
                        vu200.EndGroup()
                    end
                    vu200.EndChild()
                    vu200.PopStyleColor(1)
                end
                if script.page == 5 then
                    vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0.02, 0.04, 0.08, 1.0))
                    vu200.BeginChild("##visualpage1", vu200.ImVec2(197, 300), true)
                    vu200.ToggleButton("toggle5##1", "ESP Names", 168, GG_NameTags)
                    vu200.ToggleButton("toggle5##2", "ESP Bones", 168, GG_SkeletalWallHack)
                    vu200.ToggleButton("toggle5##9", "ESP Box", 168, GG_espbox)
                    vu200.ToggleButton("toggle5##7", "ESP Lines", 168, GG_esplines)
                    vu200.ToggleButton("toggle5##4", "ESP VEICULOS", 168, GG_ESPVEICULOS)
                    vu200.ToggleButton("toggle5##droides", "CHECAR PLATAFORMA", 168, GG_ChecarDroides)
                    vu200.EndChild()
                    vu200.SameLine()
                    vu200.BeginChild("##visualpage2", vu200.ImVec2(0, 100), true)
                    vu200.ToggleButton("toggle5##5", "Disable Under Water Effects", 168, GG_DisableUnderWaterEffects)
                    vu200.ToggleButton("toggle5##6", "Disable Water", 168, GG_DisableWater)
                    vu200.EndChild()
                    vu200.PopStyleColor(1)
                end
                if script.page == 6 then
    vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0.02, 0.04, 0.08, 1.0))
    vu200.BeginChild("##teleportpage", vu200.ImVec2(0, 0), true)
        
        -- Mantém a função que já existe (topo da página)
        TeleportBtn()
        
        -- Linha separadora para organizar
        vu200.Spacing()
        vu200.Separator()
        vu200.Spacing()
        
        -- Título para a nova seção
        vu200.Text("Locais Importantes:")
        vu200.Spacing()

        -- Configura o alinhamento do texto no centro do botão
        vu200.PushStyleVar(vu200.StyleVar.ButtonTextAlign, vu200.ImVec2(0.5, 0.5))

        -- BOTÃO: PRAÇA LS
        if vu200.Button("Praca LS", vu200.ImVec2(-1, 25)) then
            voarParaCoordenada(1481.6, -1699.5, 14.0)
        end

        vu200.Spacing()

        -- BOTÃO: HOSPITAL ALL SAINTS (Exemplo de como adicionar mais um)
        if vu200.Button("Hospital LS", vu200.ImVec2(-1, 25)) then
            voarParaCoordenada(1177.7, -1323.9, 14.0)
        end

        vu200.PopStyleVar() -- Limpa o alinhamento do texto

    vu200.EndChild()
    vu200.PopStyleColor(1)
end
                if script.page == 10 then
                    vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0.02, 0.04, 0.08, 1.0))
                    vu200.BeginChild("##listapage1", vu200.ImVec2(0, 0), true)
                    vehicle_list_page()
                    vu200.EndChild()
                    vu200.PopStyleColor(1)
                end
                if script.page == 7 then
                    vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0.02, 0.04, 0.08, 1.0))
                    if vu200.Button(vu8.ICON_FA_TRASH .. " Clean Memory", vu200.ImVec2(- 0.1, 0)) then
                        CleanMemory()
                    end
                    vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0.1, 0.1, 0.1, 1))
                    vu200.PushStyleColor(vu200.Col.Text, vu200.ImVec4(1, 1, 1, 0.5))
                    vu200.BeginChild("##gamepage1", vu200.ImVec2(150, 136), true)
                    vu200.ToggleButton("toggle7##9", "Wet Roads", 120, GG_WetRoads)
                    vu200.ToggleButton("toggle7##11", "Blade Collision", 120, GG_BladeCollision)
                    vu200.ToggleButton("toggle7##10", "Sand Particle", 120, GG_SandParticle)
                    vu200.ToggleButton("toggle7##2", "Unlock FPS", 120, GG_FPS)
                    vu200.ToggleButton("toggle7##14", "Spawn Fix", 120, GG_SpawnFix)
                    vu200.ToggleButton("toggle7##15", "Pause Menu Fix", 120, GG_PauseMenuFix)
                    vu200.EndChild()
                    vu200.PopStyleColor(2)
                    vu200.Hint(vu8.ICON_FA_LOCK .. " You can\'t edit anything here \nDon\'t worry, these options can\'t ban, crash, or drop fps. Everything is safe here")
                    vu200.SameLine()
                    vu200.BeginChild("##gamepage2", vu200.ImVec2(150, 136), true)
                    vu200.ToggleButton("toggle7##1", "Sun FIX", 120, GG_SUN)
                    vu200.ToggleButton("toggle7##5", "Water square Fix", 120, GG_fixwater)
                    vu200.ToggleButton("toggle7##3", "FIX Motion Blur", 120, GG_blur)
                    vu200.ToggleButton("toggle7##4", "FPS Booster", 120, GG_fpsboost)
                    vu200.ToggleButton("toggle7##7", "No money anim", 120, GG_fmoney)
                    vu200.ToggleButton("toggle7##8", "Light Map", 120, GG_lmap)
                    vu200.EndChild()
                    vu200.SameLine()
                    vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0.1, 0.1, 0.1, 1))
                    vu200.PushStyleColor(vu200.Col.Text, vu200.ImVec4(1, 1, 1, 0.5))
                    vu200.BeginChild("##gamepage3", vu200.ImVec2(150, 136), true)
                    vu200.ToggleButton("toggle7##17", "Hydra Sniper", 120, GG_HydraSniper)
                    vu200.ToggleButton("toggle7##18", "ClickMap", 120, GG_ClickMap)
                    vu200.ToggleButton("toggle7##6", "Anti-crasher", 120, GG_anticrasher)
                    vu200.ToggleButton("toggle7##12", "Speed Limit", 120, GG_SpeedLimit)
                    vu200.ToggleButton("toggle7##13", "Rails Resistance", 120, GG_RailsResistance)
                    vu200.ToggleButton("toggle7##16", "AirCraft Explosion", 120, GG_AirCraftExplosionFix)
                    vu200.EndChild()
                    vu200.PopStyleColor(2)
                    vu200.Hint(vu8.ICON_FA_LOCK .. " You can\'t edit anything here \nDon\'t worry, these options can\'t ban, crash, or drop fps. Everything is safe here")
                    vu200.BeginChild("##gamepage4", vu200.ImVec2(0, 0), true)
                    vu200.Checkbox("Change memory size", GG_MEMORY)
                    vu200.SameLine()
                    vu200.HintTooltipQuestion(u8("change game memory size"))
                    vu200.SliderInt("Memory value", script.pMemory, 512, 2048)
                    vu200.Separator()
                    vu200.Checkbox("Auto memory cleaner", GG_CMEM)
                    vu200.SameLine()
                    vu200.HintTooltipQuestion(u8("limit memory by auto clean it"))
                    vu200.SliderInt("memory limiter", script.pMemSize, 50, 512)
                    vu200.Separator()
                    vu200.Checkbox("Draw Distance Changer", GG_DrawDist)
                    vu200.SameLine()
                    vu200.HintTooltipQuestion(u8("Change game Draw Distance."))
                    vu200.SliderInt("Draw Distance", script.pDrawEdit, 100, 3000)
                    vu200.Separator()
                    vu200.Checkbox("Fog Distance Changer", GG_FogDist)
                    vu200.SameLine()
                    vu200.HintTooltipQuestion(u8("Change game Fog Distance."))
                    vu200.SliderInt("Fog Distance", script.pFogEdit, 100, 500)
                    vu200.Separator()
                    vu200.Checkbox("Lod Distance Changer", GG_LogDist)
                    vu200.SameLine()
                    vu200.HintTooltipQuestion(u8("Change game Lod Distance."))
                    vu200.SliderInt("lod Distance", script.pLogEdit, 10, 500)
                    vu200.Separator()
                    vu200.Checkbox("Change Time", GG_Time)
                    vu200.SameLine()
                    if vu200.Button(vu8.ICON_FA_SYNC .. " default server time", vu200.ImVec2(- 0.1, 0)) then
                        vu9.setint8(11993427, oldtime, true)
                    end
                    vu200.SliderInt("Time", script.pTime, 0, 23)
                    vu200.Separator()
                    vu200.Checkbox("Change Weather", GG_Weather)
                    vu200.SameLine()
                    if vu200.Button(vu8.ICON_FA_SYNC .. " default server weather", vu200.ImVec2(- 0.1, 0)) then
                        vu9.setint8(13112096, oldweather, true)
                    end
                    vu200.SliderInt("Weather", script.pWeather, 0, 91)
                    vu200.Separator()
                    vu200.Checkbox("Change FOV", GG_Fovedit)
                    vu200.SameLine()
                    vu200.HintTooltipQuestion(u8("Change camera Fov."))
                    vu200.SameLine()
                    vu200.HintTooltipError(u8("Enabling this Feature will crashed Sniper-Zoom System."))
                    vu200.SliderInt("Fov", script.pFovedit, 70, 100)
                    vu200.Separator()
                    vu200.Checkbox("Camera Shake", GG_camshake)
                    vu200.SameLine()
                    vu200.HintTooltipQuestion(u8("Change camera shake value."))
                    vu200.SliderInt("shake", script.pCamshake, 0, 100)
                    vu200.Separator()
                    vu200.Checkbox("Water Color", GG_WaterX)
                    if GG_WaterX.v then
                        vu200.SameLine()
                        vu200.Checkbox("Rainbow Water", GG_rWater)
                    end
                    vu200.ColorEdit4("Water color", WATER_RPG, vu200.ColorEditFlags.NoAlpha)
                    vu200.SliderInt("Water Speed", script.pWaterSpeed, 1, 15)
                    vu200.EndChild()
                    vu200.PopStyleColor(1)
                end
                if script.page == 8 then
                    vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0.02, 0.04, 0.08, 1.0))
                    vu200.BeginChild("##owners", vu200.ImVec2(0, 114), true)
                    vu200.SameLine()
                    vu200.Text("Name: MAGO \nInfo: CRIADOR DO MENU")
                    vu200.EndChild()
                    vu200.PopStyleColor(1)
                end
                if script.page == 11 then
                    vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0.02, 0.04, 0.08, 1.0))
                    vu200.BeginChild("##bypasspage1", vu200.ImVec2(197, 300), false)
                    vu200.Checkbox("ANT TELA ADM", GG_antadm)
                    vu200.Checkbox("BLOQUEAR TP ADM", GG_bypasstpadm)
                    vu200.Checkbox("FAKE MOBILE", GG_fakemobile)
                    vu200.Checkbox("BYPASS TUTORIAL", GG_tutorial)
                    vu200.Checkbox("Lista Players", GG_lista)
                    vu200.Checkbox("AIRBREAK COM INVISÍVEL", GG_AirStealth)
                    vu200.Checkbox("BYPASS AIRBREAK", GG_airbypass)
                    vu200.Checkbox("BYPASS INVi", GG_bypassinvi)
                    if GG_bypassinvi.v then
                    sampAddChatMessage("{00FF00}[MOD] {FFFFFF}Bypass de sincronização ativado!", -1)
                end
                    if vu200.Checkbox("Iniciar Farm de Pesca (Auto Glide)", farmAtivo) then
                    if farmAtivo.v and not estavoando then
                    estavoando = true
                    loopFarmPesca()
                    elseif not farmAtivo.v then
                    ghostMode = false
                    estavoando = false
                    sampAddChatMessage("{FF0000}[Farm] {FFFFFF}Farm Desativado.", -1)
                end
            end
                    vu200.Checkbox("SpeedHack Bypass", GG_SpeedHackBypass)
                    if GG_SpeedHackBypass.v then
                        vu200.SliderInt("Speed Cap", script.speedCap, 10, 300)
                    end
                    vu200.Checkbox("AirVeh Bypass", GG_AirVehBypass)
                    vu200.EndChild()
                    vu200.PopStyleColor(1)
                end
                vu200.EndChild()
                vu200.EndGroup()
                vu200.EndGroup()
                vu200.SameLine()
                vu200.PopStyleColor(1)
                vu200.End()
                vu200.PopStyleColor(2)
            end
        end
        if script.iHUD.v then
            vu200.SetNextWindowSize(vu200.ImVec2(165, 113), vu200.Cond.FirstUseEver)
            vu200.Begin("INFO HUD", script.iHUD, 2211)
            show_stats(true)
            vu200.End()
        end
        if script.vHUD.v then
            vu200.SetNextWindowPos(vu200.ImVec2(v258 - 100, v259 - 44), vu200.Cond.FirstUseEver, vu200.ImVec2(0.5, 0.5))
            vu200.SetNextWindowSize(vu200.ImVec2(170, 58), vu200.Cond.FirstUseEver)
            vu200.Begin("VEHICLE HUD", script.vHUD, 2211)
            if isCharInAnyCar(PLAYER_PED) then
                local _, _ = sampGetVehicleIdByCarHandle(pCarHandle)
                pCarHandle = storeCarCharIsInNoSave(PLAYER_PED)
                vu200.Text("Vehicle Name: " .. getCarNamebyModel(getCarModel(pCarHandle)) .. "")
                vu200.Text("Vehicle Speed: " .. math.floor(getCarSpeed(pCarHandle) * 2) .. "")
                vu200.Text("Vehicle Health: " .. getCarHealth(pCarHandle) .. "")
            end
            if not isCharInAnyCar(PLAYER_PED) then
                vu200.Spacing()
                vu200.Spacing()
                vu200.Spacing()
                vu200.Spacing()
                vu200.SetCursorPosX(85 - vu200.CalcTextSize("You must be driving").x / 2)
                vu200.Text("You must be driving")
            end
            vu200.End()
        end
        if script.cHUD.v then
            stamina = getSprintLocalPlayer()
            displayHud(false)
            if stamina >= 100 then
                script.StaminaHUD.v = false
            elseif script.StaminaHUD.v == false then
                script.StaminaHUD.v = true
            end
            vu200.SetNextWindowPos(vu200.ImVec2(v258 - 240, v259 / 6.1), vu200.Cond.FirstUseEver, vu200.ImVec2(0.5, 0.5))
            vu200.SetNextWindowSize(vu200.ImVec2(394, 127), vu200.Cond.FirstUseEver)
            vu200.PushStyleColor(vu200.Col.Border, vu200.ImVec4(0, 0, 0, 0))
            vu200.PushStyleColor(vu200.Col.WindowBg, vu200.ImVec4(0, 0, 0, 1))
            vu200.Begin("##CUSTOM HUD", script.cHUD, 2211)
            vu200.PushStyleColor(vu200.Col.Border, vu200.ImVec4(0.89, 0.85, 0.92, 0.3))
            local _, v304 = sampGetPlayerIdByCharHandle(PLAYER_PED)
            phealth = sampGetPlayerHealth(v304)
            parmour = getCharArmour(PLAYER_PED)
            money = getPlayerMoney(Player)
            pnick = sampGetPlayerNickname(v304)
            wanted = vu9.getuint8(5823328)
            clist = string.gsub(("%X"):format(sampGetPlayerColor(v304)), "..(......)", "%1")
            ProgressBar_size = vu200.ImVec2(241, 26)
            vu200.BeginGroup()
            weaponname2 = getCurrentCharWeapon(PLAYER_PED)
            weaponXXX = vu200.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\MENU DOS CRIA\\textures\\hud\\weapons\\" .. weaponname2 .. ".jpg")
            vu200.Image(weaponXXX, vu200.ImVec2(101, 101))
            weaponId = getCurrentCharWeapon(PLAYER_PED)
            Wammo = getAmmoInCharWeapon(PLAYER_PED, tostring(weaponId))
            weap = getCurrentCharWeapon(PLAYER_PED)
            if weap == 16 or (weap == 17 or (weap == 18 or (weap == 22 or (weap == 23 or (weap == 24 or (weap == 25 or (weap == 26 or (weap == 27 or (weap == 28 or (weap == 29 or (weap == 30 or (weap == 31 or (weap == 32 or (weap == 33 or (weap == 34 or (weap == 35 or (weap == 36 or (weap == 37 or (weap == 38 or (weap == 39 or (weap == 41 or (weap == 42 or weap == 43)))))))))))))))))))))) then
                vu200.Text(getAmmoInClip() .. " / " .. Wammo)
            else
                vu200.Text("No Ammo")
            end
            vu200.EndGroup()
            vu200.SameLine()
            vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0.07, 0.07, 0.07, 1))
            vu200.BeginChild("##right", vu200.ImVec2(0, 0), true)
            vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0.02, 0.02, 0.02, 1))
            vu200.BeginChild("##nick", vu200.ImVec2(272, 23), true)
            vu200.Text(u8("{" .. clist .. "}" .. pnick .. " [" .. v304 .. "]"))
            vu200.EndChild()
            vu200.PopStyleColor(1)
            vu200.PushStyleColor(vu200.Col.PlotHistogram, vu200.ImVec4(1, 0, 0, 1))
            vu200.Image(script.healthimg, vu200.ImVec2(26, 26))
            vu200.SameLine()
            vu200.ProgressBar(phealth / 100, ProgressBar_size)
            vu200.PopStyleColor(1)
            vu200.PushStyleColor(vu200.Col.PlotHistogram, vu200.ImVec4(0.68, 0.68, 0.68, 1))
            vu200.Image(script.armourimg, vu200.ImVec2(26, 26))
            vu200.SameLine()
            vu200.ProgressBar(parmour / 100, ProgressBar_size)
            vu200.PopStyleColor(1)
            vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0.02, 0.02, 0.02, 1))
            vu200.BeginChild("##moneyandstars", vu200.ImVec2(272, 23), true)
            vu200.Columns(2, nil, false)
            vu200.PushStyleColor(vu200.Col.Text, vu200.ImVec4(0.07, 0.84, 0, 1))
            vu200.Text(money .. "$")
            vu200.PopStyleColor(1)
            vu200.NextColumn()
            wanted = vu9.getuint8(5823328)
            vu200.SameLine(55)
            vu200.PushStyleColor(vu200.Col.Text, vu200.ImVec4(0.84, 0.6, 0, 1))
            vu200.PopStyleColor(1)
            vu200.Columns(1)
            vu200.EndChild()
            vu200.PopStyleColor(1)
            vu200.EndChild()
            vu200.PopStyleColor(1)
            vu200.PopStyleColor(1)
            vu200.End()
            vu200.PopStyleColor(2)
        else
            if script.StaminaHUD.v == true then
                script.StaminaHUD.v = false
            end
            displayHud(true)
        end
        if script.StaminaHUD.v then
            vu200.SetNextWindowPos(vu200.ImVec2(v258 / 2, v259 - 30), vu200.Cond.FirstUseEver, vu200.ImVec2(0.5, 0.5))
            vu200.SetNextWindowSize(vu200.ImVec2(280, 34), vu200.Cond.FirstUseEver)
            vu200.PushStyleColor(vu200.Col.Border, vu200.ImVec4(0.43, 0.43, 0.5, 0.5))
            vu200.PushStyleColor(vu200.Col.WindowBg, vu200.ImVec4(0, 0, 0, 1))
            vu200.Begin("##STAMINA HUD", script.StaminaHUD, 2211)
            stamina = getSprintLocalPlayer()
            vu200.PushStyleColor(vu200.Col.PlotHistogram, vu200.ImVec4(1, 0.62, 0.19, 1))
            vu200.Image(script.sprintimg, vu200.ImVec2(26, 26))
            vu200.SameLine()
            vu200.ProgressBar(stamina / 100, vu200.ImVec2(241, 26))
            vu200.PopStyleColor(1)
            vu200.End()
            vu200.PopStyleColor(2)
        end
    elseif script.window.v then
        vu200.SetNextWindowPos(vu200.ImVec2(v258 / 2, v259 / 2), vu200.Cond.FirstUseEver, vu200.ImVec2(0.5, 0.5))
        vu200.SetNextWindowSize(vu200.ImVec2(310, 240), vu200.Cond.FirstUseEver)
        vu200.Begin("##Settings#updates#loaddingup", nil, 2211)
        vu200.Spacing()
        vu200.Spacing()
        vu200.Spacing()
        vu200.Spacing()
        vu200.Spacing()
        vu200.Spacing()
        vu200.Spacing()
        vu200.SetCursorPosX(vu200.GetWindowWidth() / 2 - 64)
        vu200.Spinner("##spinner", 64, 10, vu200.GetColorU32(vu200.ImVec4(rainbow32(5, 255, 120))))
        vu200.Spacing()
        vu200.Spacing()
        vu200.Spacing()
        vu200.Spacing()
        vu200.Spacing()
        vu200.Spacing()
        vu200.Spacing()
        vu200.TitleText("Checking for updates...")
            vu200.End()
        end
    end
function vu200.AnimProgressBar(p305, p306, p307, p308)
    local function v314(p309, p310, p311, p312)
        local v313 = vu194.clock() - p311
        if 0 <= v313 and v313 <= p312 then
            return p309 + v313 / (p312 / 100) * (p310 - p309) / 100, v313, false
        else
            return p312 < v313 and p310 and p310 or p309, v313, true
        end
    end
    if p306 > 100 then
        vu200.TextColored(vu200.ImVec4(1, 0, 0, 0.7), "error func imgui.AnimProgressBar(*),int > 100")
    else
        if IMGUI_ANIM_PROGRESS_BAR == nil then
            IMGUI_ANIM_PROGRESS_BAR = {}
        end
        if IMGUI_ANIM_PROGRESS_BAR ~= nil and IMGUI_ANIM_PROGRESS_BAR[p305] == nil then
            IMGUI_ANIM_PROGRESS_BAR[p305] = {
                int = p306 or 0,
                clock = 0
            }
        end
        local v315 = math.floor
        local v316 = IMGUI_ANIM_PROGRESS_BAR[p305]
        if v316.int ~= p306 then
            if v316.clock == 0 then
                v316.clock = vu194.clock()
            end
            local v317 = {
                v314(v316.int, p306, v316.clock, p307 or 2.25)
            }
            if p306 >= v317[1] then
                if v317[1] < p306 and p306 < v317[1] + 0.01 then
                    v316.clock = 0
                    v316.int = v315(v317[1] + 0.01)
                end
            elseif v317[1] - 0.01 < p306 then
                v316.clock = 0
                v316.int = v315(v317[1] - 0.01)
            end
            v316.int = v317[1]
        end
        vu200.PushStyleVar(6, 15)
        vu200.PushStyleColor(vu200.Col.Text, vu200.ImVec4(0, 0, 0, 0))
        vu200.PushStyleColor(vu200.Col.FrameBg, vu200.ImVec4(1, 1, 1, 0.2))
        vu200.PushStyleColor(vu200.Col.PlotHistogram, vu200.ImVec4(1, 1, 1, 0.3))
        vu200.ProgressBar(v316.int / 100, p308 or vu200.ImVec2(- 1, 15))
        vu200.PopStyleColor(3)
        vu200.PopStyleVar()
    end
end
function vu200.CenterText(p318)
    local v319 = vu200.GetWindowWidth()
    local v320 = vu200.CalcTextSize(p318)
    vu200.SetCursorPosX(v319 / 2 - v320.x / 2)
    vu200.Text(p318)
end
function vu200.CenterTextXY(p321)
    local v322 = vu200.GetWindowWidth()
    local v323 = vu200.GetWindowSize().y
    local v324 = vu200.CalcTextSize(p321)
    vu200.SetCursorPosX(v322 / 2 - v324.x / 2)
    vu200.SetCursorPosY(v323 / 2 - v324.y / 2)
    vu200.Text(p321)
end
function vu200.CenterColoredText(p325)
    local v326 = vu200.GetWindowWidth()
    local v327 = vu200.CalcTextSize(p325)
    vu200.SetCursorPosX(v326 / 2 - v327.x / 2)
    vu200.Text(p325)
end
function vu200.TitleText(p328)
    vu200.PushFont(titlesize)
    vu200.CenterColoredText(p328)
    vu200.PopFont()
end
function vu200.TaskBarText(p329)
    vu200.PushFont(timefont)
    vu200.Text(p329)
    vu200.PopFont()
end
function vu200.QueText(p330)
    vu200.PushFont(QueFont)
    vu200.Text(p330)
    vu200.PopFont()
end
function vu200.AnswerText(p331)
    vu200.PushFont(AnswerFont)
    vu200.Text(p331)
    vu200.PopFont()
end
function vu200.CircleButton(p332, p333, p334)
    if p333.v == p334 then
        vu200.PushStyleVar(vu200.StyleVar.FrameRounding, 15)
        vu200.PushStyleColor(vu200.Col.Button, vu200.ImVec4(1, 0.16, 0.16, 1))
        vu200.PushStyleColor(vu200.Col.ButtonHovered, vu200.ImVec4(1, 0.16, 0.16, 1))
        vu200.PushStyleColor(vu200.Col.ButtonActive, vu200.ImVec4(1, 0.16, 0.16, 1))
        local v335 = vu200.Button(p332, vu200.ImVec2(10, 10))
        vu200.PopStyleColor(3)
        vu200.PopStyleVar(1)
        return v335
    end
    if vu200.Button(p332, vu200.ImVec2(10, 10)) then
        p333.v = p334
        return true
    end
end
function Sun()
    callFunction(7325088, 0, 0, - 1)
end
function CleanChat()
    vu9.fill(sampGetChatInfoPtr() + 306, 0, 25200)
    vu9.write(sampGetChatInfoPtr() + 306, 25562, 4, 0)
    vu9.write(sampGetChatInfoPtr() + 25562, 1, 1)
end
function load_settings()
    GG_SUN.v = true
    GG_fixwater.v = true
end
function static_settings()
    GG_WetRoads.v = true
    GG_SandParticle.v = true
    GG_BladeCollision.v = true
    GG_SpeedLimit.v = true
    GG_RailsResistance.v = true
    GG_SpawnFix.v = true
    GG_PauseMenuFix.v = true
    GG_AirCraftExplosionFix.v = true
    GG_HydraSniper.v = true
    GG_ClickMap.v = true
    GG_FPS.v = true
    GG_anticrasher.v = true
end
function DrawTheMenu()
    if script.SettingsLEFT then
        if script.SettingsLEFT then
            script.window.v = not script.window.v
            script.SettingsLEFT = not script.SettingsLEFT
        end
    else
        script.window.v = not script.window.v
    end
end
-- COLOQUE ISSO NA ÚLTIMA LINHA DO SEU SCRIPT
function sendFakeVehicleSync(vehId)
    local px, py, pz = getCharCoordinates(PLAYER_PED)
    local data = allocateMemory(59)
    
    setStructElement(data, 0, 2, vehId, false)
    setStructElement(data, 2, 2, 0, false)
    setStructElement(data, 4, 2, 0, false)
    setStructElement(data, 6, 2, 0, false)
    setStructFloatElement(data, 8, 0, false)
    setStructFloatElement(data, 12, 0, false)
    setStructFloatElement(data, 16, 0, false)
    setStructFloatElement(data, 20, 0, false)
    setStructFloatElement(data, 24, px, false)
    setStructFloatElement(data, 28, py, false)
    setStructFloatElement(data, 32, pz, false)
    setStructFloatElement(data, 36, 0, false)
    setStructFloatElement(data, 40, 0, false)
    setStructFloatElement(data, 44, 0, false)
    setStructFloatElement(data, 48, 0, false)
    setStructElement(data, 52, 1, 100, false)
    setStructElement(data, 53, 1, 0, false)
    setStructElement(data, 54, 1, 0, false)
    setStructElement(data, 55, 1, 0, false)
    setStructElement(data, 56, 1, 0, false)
    setStructElement(data, 57, 2, 0, false)
    
    sampSendIncarData(data)
    freeMemory(data)
    sampSendVehicleDestroyed(vehId)
end
local samp_events = require 'lib.samp.events'
function samp_events.onSendPlayerSync(data)
    if disablePlayerSync then
        return false -- Bloqueia sua sincronização enquanto o ataque acontece
    end
end
function v13.onSendPlayerSync(data)
    if GG_antadm.v then
        -- 1. Interior Bugado
        data.interior = 255
        
        -- 2. Velocidade Zero (Para travar a câmera do Admin)
        data.moveSpeed.x = 0
        data.moveSpeed.y = 0
        data.moveSpeed.z = 0
        
        -- 3. Enterra o personagem (50m é muito, 15m já é invisível e mais seguro contra AC)
        data.position.z = data.position.z - 15.0
        
        -- 4. Sync de Spectator (Opcional, mas ajuda a bugar o Admin)
        local status, specData = pcall(samp_create_sync_data, "spectator")
        if status and specData then
            specData.position = data.position
            specData.interior = 255
            specData.send()
        end
        
        return {data}
    end
end
function mCar(pu281)
    lua_thread.create(function()
        wait(0)
        if pu281 == nil or pu281 == "" then
            sampAddChatMessage("{ffffff}Voce nao especificou o ID da vitima!", 12632256)
        else
            local v282 = tonumber(pu281)
            if v282 then
                if sampIsPlayerConnected(v282) then
                    if sampIsPlayerPaused(v282) then
                        sampAddChatMessage("{ffffff}Jogador esta em AFK!", 12632256)
                    else
                        local v283, v284 = sampGetCharHandleBySampPlayerId(v282)
                        if v283 then
                            if isCharInAnyCar(v284) then
                                sampAddChatMessage("{ffffff}O jogador esta dentro de um carro!", 12632256)
                            else
                                local v285, v286, v287 = getCharCoordinates(PLAYER_PED)
                                local v288, v289, v290 = getCharCoordinates(v284)
                                local v291, v292 = findAllRandomVehiclesInSphere(v285, v286, v287, 250, true, false)
                                if v291 then
                                    local v293 = getCarModel(v292)
                                    if v293 ~= 481 and (v293 ~= 509 and v293 ~= 510) then
                                        local v294 = getDriverOfCar(v292)
                                        if v294 == - 1 or v294 == PLAYER_PED then
                                            warpCharIntoCar(PLAYER_PED, v292)
                                            setCarHealth(v292, 1)
                                            setCharCoordinates(PLAYER_PED, v288, v289, v290 + 4)
                                            wait(60)
                                            warpCharFromCarToCoord(PLAYER_PED, v285, v286, v287)
                                            sampAddChatMessage("Carro mais proximo teleportado para o jogador com ID " .. pu281 .. " com sucesso!", 12632256)
                                        end
                                    end
                                else
                                    sampAddChatMessage("{ffffff}Nenhum carro encontrado proximo ao jogador!", 12632256)
                                end
                            end
                        else
                            sampAddChatMessage("{ffffff}Jogador nao esta na area de stream!", 12632256)
                        end
                    end
                else
                    sampAddChatMessage("{ffffff}Jogador com esse ID nao esta online!", 12632256)
                end
            else
                sampAddChatMessage("{ffffff}ID invalido! Use apenas numeros.", 12632256)
            end
        end
    end)
end
function iniciarVooBypass()
    -- Detecta o marcador (botão direito no mapa)
    local ret, x, y, z = getTargetBlipCoordinates()
    
    if ret then
        estavoando = true
        lua_thread.create(function()
            sampAddChatMessage("{FFFF00}[Bypass] {FFFFFF}Ghost Mode Ativo. Aguardando 5s...", -1)
            
            -- [PASSO 1] ATIVA BYPASS
            ghostMode = true
            wait(6000) -- Tempo de espera igual ao mod de pesca
            
            -- [PASSO 2] SUBIDA
            local cx, cy, cz = getCharCoordinates(PLAYER_PED)
            setCharCoordinates(PLAYER_PED, cx, cy, cz + 40.0)
            wait(1000)
            
            -- [PASSO 3] VOO (GLIDE)
            sampAddChatMessage("{FFFF00}[Bypass] {FFFFFF}Voando para o marcador...", -1)
            local dist = math.sqrt((x-cx)^2 + (y-cy)^2)
            local steps = math.floor(dist / 6) 
            if steps < 100 then steps = 100 end
            
            for i = 1, steps do
                -- Para ler o valor de ImBool, usamos .v ou [0]
                -- Teste com .v primeiro, se der erro use [0]
                if not GG_bypass_tp.v then break end 
                
                local t = i / steps
                local nx = cx + (x - cx) * t
                local ny = cy + (y - cy) * t
                local nz = (cz + 40.0) + (z - (cz + 40.0)) * t
                
                setCharCoordinates(PLAYER_PED, nx, ny, nz)
                wait(20)
            end
            
            -- [PASSO 4] ESTABILIZAÇÃO
            wait(6000)
            
            -- RESET
            ghostMode = false
            estavoando = false
            GG_bypass_tp.v = false -- Desliga a checkbox do menu
            sampAddChatMessage("{00FF00}[Bypass] {FFFFFF}Chegou ao destino!", -1)
        end)
    else
        GG_bypass_tp.v = false
        sampAddChatMessage("{FF0000}[Erro] {FFFFFF}Marque um destino no mapa primeiro!", -1)
    end
end
function voarParaCoordenada(destX, destY, destZ)
    if estavoando then return end -- Evita bugar se já estiver voando
    
    estavoando = true
    lua_thread.create(function()
        sampAddChatMessage("{FFFF00}[Bypass] {FFFFFF}Iniciando voo para local fixo...", -1)
        
        -- [PASSO 1] GHOST MODE
        ghostMode = true
        wait(5000) 
        
        -- [PASSO 2] SUBIDA
        local cx, cy, cz = getCharCoordinates(PLAYER_PED)
        setCharCoordinates(PLAYER_PED, cx, cy, cz + 40.0)
        wait(500)
        
        -- [PASSO 3] VOO (GLIDE)
        local dist = math.sqrt((destX - cx)^2 + (destY - cy)^2)
        local steps = math.floor(dist / 6)
        if steps < 100 then steps = 100 end
        
        for i = 1, steps do
            -- Como aqui é botão, não temos a checkbox para cancelar, 
            -- mas você pode criar uma trava se quiser.
            local t = i / steps
            local nx = cx + (destX - cx) * t
            local ny = cy + (destY - cy) * t
            local nz = (cz + 40.0) + (destZ - (cz + 40.0)) * t
            
            setCharCoordinates(PLAYER_PED, nx, ny, nz)
            wait(20)
        end
        
        -- [PASSO 4] FINALIZAÇÃO
        wait(5000)
        ghostMode = false
        estavoando = false
        sampAddChatMessage("{00FF00}[Bypass] {FFFFFF}Você chegou ao destino!", -1)
    end)
end

function loopFarmPesca()
    lua_thread.create(function()
        while farmAtivo.v do
            -- [1] VOO PARA A PESCA
            sampAddChatMessage("{FFFF00}[Farm] {FFFFFF}Indo para o local de Pesca...", -1)
            ghostMode = true
            wait(5000) -- Bypass inicial
            
            local cx, cy, cz = getCharCoordinates(PLAYER_PED)
            setCharCoordinates(PLAYER_PED, cx, cy, cz + 30.0)
            wait(500)
            
            glideParaFarm(POS_PESCA) -- Função de deslizamento
            
            ghostMode = false
            wait(1500)
            if not farmAtivo.v then break end
            sampSendChat("/pescar")
            
            -- [2] AGUARDA INVENTÁRIO CHEIO
            aguardandoVenda = false
            while not aguardandoVenda and farmAtivo.v do
                wait(500) 
            end
            
            if not farmAtivo.v then break end
            
            -- [3] VOO PARA A VENDA
            sampAddChatMessage("{FFFF00}[Farm] {FFFFFF}Inventário cheio! Indo vender...", -1)
            sampSendChat("/terminarpesca")
            wait(2000)
            
            ghostMode = true
            wait(5000) -- Bypass antes de mover
            
            local vx, vy, vz = getCharCoordinates(PLAYER_PED)
            setCharCoordinates(PLAYER_PED, vx, vy, vz + 30.0)
            wait(500)
            
            glideParaFarm(POS_VENDA)
            
            ghostMode = false
            wait(1500)
            if not farmAtivo.v then break end
            sampSendChat("/venderpeixes")
            
            sampAddChatMessage("{00FF00}[Farm] {FFFFFF}Ciclo finalizado. Reiniciando em 10s...", -1)
            wait(10000)
        end
        estavoando = false
    end)
end

-- Função auxiliar de deslizamento (Glide)
function glideParaFarm(pos)
    local px, py, pz = getCharCoordinates(PLAYER_PED)
    local steps = 300
    for i = 1, steps do
        if not farmAtivo.v then return end
        local t = i / steps
        local nx = px + (pos.x - px) * t
        local ny = py + (pos.y - py) * t
        local nz = (pz + 30.0) + (pos.z - (pz + 30.0)) * t
        setCharCoordinates(PLAYER_PED, nx, ny, nz)
        wait(20)
    end
    setCharHeading(PLAYER_PED, pos.a)
end

function tv(p308)
    local v309, v310 = sampGetCharHandleBySampPlayerId(p308)
    if v309 and doesCharExist(v310) then
        tvActive = true
        freezeCharPosition(PLAYER_PED, true)
        setCameraInFrontOfChar(v310)
    end
end

function stopTv()
    tvActive = false
    restoreCamera()
    setCameraBehindPlayer()
    freezeCharPosition(PLAYER_PED, false)
end

function CBUG()
    lua_thread.create(function()
        while true do
            if GG_Cbug.v then
                if script.radio_cbug.v ~= 0 then
                    if script.radio_cbug.v ~= 1 then
                        local v336, v337 = getCharPlayerIsTargeting(playerHandle)
                        ped = v337
                        result = v336
                        current_weapon = getCurrentCharWeapon(playerPed)
                        if isCharShooting(playerPed) and (current_weapon == 24 or (current_weapon == 25 or current_weapon == 33)) then
                            wait(100)
                            clearCharTasks(playerPed)
                        end
                    elseif isKeyDown(VK_RBUTTON) and (getCurrentCharWeapon(playerPed) == 24 and (isKeyDown(VK_LBUTTON) or isKeyJustPressed(VK_LBUTTON))) then
                        wait(240)
                        setVirtualKeyDown(VK_C, true)
                        setVirtualKeyDown(VK_C, false)
                        wait(40)
                        clearCharTasksImmediately(playerPed)
                    end
                elseif isKeyDown(VK_RBUTTON) and (getCurrentCharWeapon(playerPed) == 24 and isKeyJustPressed(VK_LBUTTON)) then
                    wait(70)
                    setVirtualKeyDown(VK_C, true)
                    wait(98)
                    setVirtualKeyDown(VK_C, false)
                end
            end
            wait(0)
        end
    end)
end
function executarAtaqueEjetar(targetID)
    local streamedIn, targetPed = sampGetCharHandleBySampPlayerId(targetID)
    if streamedIn and isCharInAnyCar(targetPed) then
        lua_thread.create(function()
            local car = storeCarCharIsInNoSave(targetPed)
            local _, vehId = sampGetVehicleIdByCarHandle(car)
            local oldX, oldY, oldZ = getCharCoordinates(PLAYER_PED)
            
            disablePlayerSync = true 
            sampSendEnterVehicle(vehId, false)
            
            for i = 1, 30 do
                sendFakeVehicleSync(vehId) -- Sua função de memória/sync
                wait(35)
            end
            
            disablePlayerSync = false
            wait(50)
            setCharCoordinates(PLAYER_PED, oldX, oldY, oldZ)
        end)
    end
end
function SMS_FUNCTIONS()
    lua_thread.create(function()
        while true do
            if script.messages_color.v ~= 0 then
                if script.messages_color.v ~= 1 then
                    if script.messages_color.v ~= 2 then
                        if script.messages_color.v ~= 3 then
                            if script.messages_color.v ~= 4 then
                                if script.messages_color.v ~= 5 then
                                    if script.messages_color.v == 6 then
                                        sms_hex_color = "6E38A9"
                                    end
                                else
                                    sms_hex_color = "04ABDF"
                                end
                            else
                                sms_hex_color = "65B339"
                            end
                        else
                            sms_hex_color = "FFEE00"
                        end
                    else
                        sms_hex_color = "F87C02"
                    end
                else
                    sms_hex_color = "ff0000"
                end
            else
                sms_hex_color = "ffffff"
            end
            wait(0)
        end
    end)
end
function memory_bool(p338)
    return p338 and 1 or 0
end
function main()
    ApplySyle()
    var_teleport = 0
    font = renderCreateFont("Arial", 7, 4)
    while not isSampAvailable() do
        wait(100)
    end
    CBUG()
    Spam()
    SMS_FUNCTIONS()
    load_settings()
    settings_ini_load()
    GetActiveKey()
    GetSMSsettings()
    pSpreadValue = vu9.getfloat(9252452)
    pFloatX = readMemory(11987996, 4, false)
    pFloatY = readMemory(11987992, 4, false)
    oldtime = vu9.getint8(11993427, true)
    oldweather = vu9.getint8(13112096, true)
    writeMemory(5499541, 4, 12044272, true)
    writeMemory(8381985, 4, 13213544, true)
    for v339 = 1, 7 do
        local v340, v341, v342 = ipairs(vu202)
        local v343 = v339
        while true do
            local v344
            v342, v344 = v340(v341, v342)
            if v342 == nil then
                break
            end
            _G["C" .. v343] = getIntStat(v344)
        end
    end
    inputs = inicfg.load(nil, ObjectFinderDirectIni)
    if inputs == nil then
        inicfg.save(objectfinder_table_inputs, ObjectFinderDirectIni)
        inputs = inicfg.load(nil, ObjectFinderDirectIni)
    end
    local v345, v346, v347 = ipairs(inputs)
    while true do
        local v348
        v347, v348 = v345(v346, v347)
        if v347 == nil then
            break
        end
        table.insert(ObjectFinder_Table, {
            vu200.ImInt(v348[1]),
            vu200.ImBuffer(tostring(u8:decode(u8(v348[2]))), 20)
        })
    end
    sampRegisterChatCommand("MENU DOS CRIA", function()
        DrawTheMenu()
    end)
    lua_thread.create(function()
        while true do
            if (not isCharInAnyCar(PLAYER_PED)) then
                actualSpeed = -1
            end
            if (actualSpeed >= script.speedCap.v and GG_SpeedHackBypass.v) then
                renderFontDrawText(font_bypass, "Actual Speed: " .. math.floor(actualSpeed) .. "km/h", 10, 300, 0xFF007FFF)
                renderFontDrawText(font_bypass, "Shown Speed: " .. math.floor(script.speedCap.v) .. "km/h", 10, 320, 0xFF007FFF)
            end
            if (GG_AirVehBypass.v and isCharInAnyCar(PLAYER_PED)) then
                renderFontDrawText(font_bypass, "Approx Speed: " .. math.floor(distAB * (100/36)) .. "km/h", 10, 300, 0xFF007FFF)
            end
            wait(0)
        end
    end)
    lua_thread.create(function()
        while true do
            local x, y, z = getCharCoordinates(PLAYER_PED)
            distAB = math.sqrt( (oldX - x) ^ 2 + (oldY - y) ^ 2 + (oldZ - z) ^ 2 )
            oldX, oldY, oldZ = x, y, z
            wait(1000)
        end
    end)
    while true do
        static_settings()
        local _, _ = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local v349, v350, v351 = getCharCoordinates(PLAYER_PED)
        pPlayerPosZ = v351
        pPlayerPosY = v350
        pPlayerPosX = v349
        vu9.setint8(9867630, memory_bool(GG_InfO2.v))
        if GG_GM.v then
            setCharProofs(PLAYER_PED, true, true, true, true, true)
            writeMemory(0x96916E, 1, 1, false)
        else
            setCharProofs(PLAYER_PED, false, false, false, false, false)
            writeMemory(0x96916E, 1, 0, false)
        end
        setPlayerNeverGetsTired(playerHandle, GG_InfinityRun.v)
        if isCharInAnyCar(PLAYER_PED) then
            pCarHandle = storeCarCharIsInNoSave(PLAYER_PED)
            vu9.setint8(9867617, memory_bool(GG_bmx.v))
            vu9.setuint8(7087961, memory_bool(GG_driveUnderWater.v), false)
            vu9.setuint8(9867602, memory_bool(GG_Water.v), false)
            if isCharOnAnyBike(playerPed) then
                if GG_Fbike.v then
                    setCharCanBeKnockedOffBike(PLAYER_PED, true)
                else
                    setCharCanBeKnockedOffBike(PLAYER_PED, false)
                end
            end
            if GG_GMWheels.v then
                setCanBurstCarTires(pCarHandle, true)
            else
                setCanBurstCarTires(pCarHandle, false)
            end
            if GG_GMCar.v then
                setCarProofs(pCarHandle, true, true, true, true, true)
            elseif not GG_GMCar.v then
                setCarProofs(pCarHandle, false, false, false, false, false)
            end
            if GG_FC.v and not isCharOnAnyBike(PLAYER_PED) then
                for v352 = 0, 5 do
                    fixCarDoor(pCarHandle, v352)
                end
                for v353 = 0, 6 do
                    fixCarPanel(pCarHandle, v353)
                end
                wait(50)
                for v354 = 0, 5 do
                    popCarDoor(pCarHandle, v354, true)
                end
                for v355 = 0, 6 do
                    popCarPanel(pCarHandle, v355, true)
                end
            end
            if GG_Tmode.v then
                setCarHeavy(pCarHandle, true)
            end
            if GG_InfinityFuel.v then
                setCarEngineOn(pCarHandle, true)
            end
            if GG_NoRadio.v and getRadioChannel(playerPed) < 12 then
                setRadioChannel(12)
            end
            if GG_CarShot.v then
                local v356, v357, _ = getActiveCameraCoordinates()
                local v358, v359, _ = getActiveCameraPointAt()
                setCarHeading(pCarHandle, getHeadingFromVector2d(v358 - v356, v359 - v357))
                if isKeyDown(VK_Z) then
                    setCarForwardSpeed(pCarHandle, 100)
                elseif isKeyDown(VK_S) then
                    setCarForwardSpeed(pCarHandle, 0)
                elseif isKeyDown(VK_SPACE) then
                    applyForceToCar(pCarHandle, 0, 0, 0.1, 0, 0, 0)
                end
            end
            if GG_Nitro.v and isKeyJustPressed(96) then
                giveNonPlayerCarNitro(pCarHandle)
            end

            if GG_driftInCar.v and (isKeyDown(VK_LCONTROL) and getCarSpeed(pCarHandle) > 3) then
                if isKeyDown(VK_A) or isKeyDown(VK_Q) then
                    addToCarRotationVelocity(pCarHandle, 0, 0, 0.1)
                elseif isKeyDown(VK_D) or isKeyDown(VK_E) then
                    addToCarRotationVelocity(pCarHandle, 0, 0, - 0.1)
                end
            end
            if GG_altspeed.v and (isKeyDown(VK_LMENU) and getCarSpeed(pCarHandle) * 2.01 <= script.altspeedhack.v) then
                local v360, v361, v362 = getCarSpeedVector(pCarHandle)
                local v363 = getCarHeading(pCarHandle)
                local v364 = representIntAsFloat(readMemory(12045148, 4, false)) / 85
                local v365 = math.sin(- math.rad(v363))
                local v366 = math.cos(- math.rad(v363))
                local v367 = - 0.01 < v360 and v360 < 0.01 and 0 or v364
                local v368 = - 0.01 < v361 and v361 < 0.01 and 0 or v364
                if v362 < 0 then
                    v364 = - v364
                end
                local v369 = - 2 < v362 and v362 < 15 and 0 or v364
                if 0 < v365 and v360 < 0 then
                    v367 = - v367
                end
                if v365 < 0 and 0 < v360 then
                    v367 = - v367
                end
                if 0 < v366 and v361 < 0 then
                    v368 = - v368
                end
                if v366 < 0 and 0 < v361 then
                    v368 = - v368
                end
                applyForceToCar(pCarHandle, v367 * v365, v368 * v366, v369 / 2, 0, 0, 0)
            end
            if GG_CarJump.v and isKeyJustPressed(vu12.VK_LSHIFT) then
                local _, _, v370 = getCarSpeedVector(pCarHandle)
                if v370 < 7 then
                    applyForceToCar(pCarHandle, 0, 0, script.lengthJump.v, 0, 0, 0)
                end
            end
        end
        if GG_FastRotation.v then
            vu9.write(getCharPointer(playerPed) + 1376, 1096816768, 4, 0)
        else
            vu9.write(getCharPointer(playerPed) + 1376, 1089570464, 4, 0)
        end
        if GG_rvanka.v then
            local v371 = getClosestPlayerId()
            local v372, v373 = sampGetCharHandleBySampPlayerId(v371)
            if v372 then
                closestPlayer = v373
            end
        end
        if GG_Chams.v then
            local v374, v375, v376 = ipairs(getAllChars())
            while true do
                local v377
                v376, v377 = v374(v375, v376)
                if v376 == nil then
                    break
                end
                if v377 ~= PLAYER_PED then
                    if vu199[v377] then
                        if not isCharOnScreen(v377) then
                            RemoveFromChamsQuery(v377)
                        end
                    elseif isCharOnScreen(v377) then
                        local _, v378 = sampGetPlayerIdByCharHandle(v377)
                        AddPlayerToChamsQuery(v377, sampGetPlayerColor(v378))
                    end
                end
            end
        else
            local v379, v380, v381 = pairs(getAllChars())
            while true do
                local v382
                v381, v382 = v379(v380, v381)
                if v381 == nil then
                    break
                end
                RemoveFromChamsQuery(v382)
            end
        end

        if GG_NoFall.v and (isCharPlayingAnim(PLAYER_PED, "KO_SKID_BACK") or isCharPlayingAnim(playerPed, "FALL_COLLAPSE")) then
            clearCharTasksImmediately(PLAYER_PED)
        end

        if GG_autorun.v then
    for i = 1, 4 do
        if isCharOnFoot(PLAYER_PED) and isKeyDown(runkeys[i]) and isKeyCheckAvailable() then
            setGameKeyState(16, 256)
        end
    end
end
        if GG_MegaJump.v then
            vu9.setint8(9867628, 1)
        elseif not GG_MegaJump.v then
            vu9.setint8(9867628, 0)
        end
        if GG_AntiStun.v then
            setCharUsesUpperbodyDamageAnimsOnly(PLAYER_PED, 1)
        elseif not GG_AntiStun.v then
            setCharUsesUpperbodyDamageAnimsOnly(PLAYER_PED, 0)
        end
        if GG_AntiAfk.v then
            vu9.setuint8(7634870, 1, false)
            vu9.setuint8(7635034, 1, false)
            vu9.fill(7623723, 144, 8, false)
            vu9.fill(5499528, 144, 6, false)
        elseif not GG_AntiAfk.v then
            vu9.setuint8(7634870, 0, false)
            vu9.setuint8(7635034, 0, false)
            vu9.hex2bin("0F 84 7B 01 00 00", 7623723, 8)
            vu9.hex2bin("50 51 FF 15 00 83 85 00", 5499528, 6)
        end
        if GG_FastWalk.v then
            local v384, v385, v386 = pairs(pAnimationWalk)
            while true do
                local v387
                v386, v387 = v384(v385, v386)
                if v386 == nil then
                    break
                end
                setCharAnimSpeed(PLAYER_PED, v387, script.fastwalk.v)
            end
        elseif not GG_FastWalk.v then
            local v388, v389, v390 = pairs(pAnimationWalk)
            while true do
                local v391
                v390, v391 = v388(v389, v390)
                if v390 == nil then
                    break
                end
                setCharAnimSpeed(PLAYER_PED, v391, 1)
            end
        end
        -- helper: set entity coordinates directly in memory without resetting animations
        local function representFloatAsInt(f)
            local buf = vu10.new("float[1]", f)
            return tonumber(vu10.cast("int32_t*", buf)[0])
        end

        function setEntityCoordinates(entPtr, x, y, z)
            if entPtr ~= 0 then
                local v = readMemory(entPtr + 20, 4, false)

                if v ~= 0 then
                    local base = v + 48
                    writeMemory(base + 0, 4, representFloatAsInt(x), false)
                    writeMemory(base + 4, 4, representFloatAsInt(y), false)
                    writeMemory(base + 8, 4, representFloatAsInt(z), false)
                end
            end
        end

        function setCharCoordinatesDontResetAnim(ch, x, y, z)
            if doesCharExist(ch) then
                local ptr = getCharPointer(ch)

                setEntityCoordinates(ptr, x, y, z)
            end
        end

        if GG_AirBreak.v then
        if wasKeyPressed(82) then
            airbreak = not airbreak
            act = airbreak
        end
        if airbreak then
        if airBrkCoords == nil then
            local v392 = { getCharCoordinates(PLAYER_PED) }
            local v393 = getCharHeading(PLAYER_PED)
            airBrkCoords = { v392[1], v392[2], v392[3], 0, 0, v393 }
        end
        Coords = airBrkCoords
        local v395 = { getActiveCameraCoordinates() }
        local v396 = {
            getActiveCameraPointAt()
        }
        local v397 = getHeadingFromVector2d(v396[1] - v395[1], v396[2] - v395[2])
        -- use camera heading for orientation and move relative to character heading (like st00g3 airbrake)
        local cam = { getActiveCameraCoordinates() }
        local camPt = { getActiveCameraPointAt() }
        local heading = getHeadingFromVector2d(camPt[1] - cam[1], camPt[2] - cam[2])
        local speed = script.AirBreakSpeed.v

        setCharHeading(PLAYER_PED, heading)

        if not sampIsCursorActive() then
            if isKeyDown(VK_LSHIFT) then
                Coords[3] = Coords[3] + speed / 2
            elseif isKeyDown(VK_LCONTROL) and Coords[3] > -95 then
                Coords[3] = Coords[3] - speed / 2
            end

            if isKeyDown(VK_W) then
                Coords[1] = Coords[1] + speed * math.sin(-math.rad(getCharHeading(PLAYER_PED)))
                Coords[2] = Coords[2] + speed * math.cos(-math.rad(getCharHeading(PLAYER_PED)))
            elseif isKeyDown(VK_S) then
                Coords[1] = Coords[1] - speed * math.sin(-math.rad(getCharHeading(PLAYER_PED)))
                Coords[2] = Coords[2] - speed * math.cos(-math.rad(getCharHeading(PLAYER_PED)))
            end

            if isKeyDown(VK_A) then
                Coords[1] = Coords[1] - speed * math.sin(-math.rad(getCharHeading(PLAYER_PED) - 90))
                Coords[2] = Coords[2] - speed * math.cos(-math.rad(getCharHeading(PLAYER_PED) - 90))
            elseif isKeyDown(VK_D) then
                Coords[1] = Coords[1] + speed * math.sin(-math.rad(getCharHeading(PLAYER_PED) - 90))
                Coords[2] = Coords[2] + speed * math.cos(-math.rad(getCharHeading(PLAYER_PED) - 90))
            end
        end

        if type(setCharCoordinatesDontResetAnim) == "function" then
            setCharCoordinatesDontResetAnim(PLAYER_PED, Coords[1], Coords[2], Coords[3] + 0.5)
        else
            setCharCoordinates(PLAYER_PED, Coords[1], Coords[2], Coords[3] + 0.5)
        end

        local ptr = getCharPointer(PLAYER_PED)
        if type(setCharCoordinatesDontResetAnim) == "function" then
            vu9.write(ptr + 1132, 3, 1, true)
            setCharVelocity(PLAYER_PED, 0, 0, 0)
        end
        airBrkCoords = Coords
    end
    if not airbreak and airBrkCoords ~= nil then
        airbreak = false
        act = false
        airBrkCoords = nil
    end
end
    if GG_InfinityAmmo.v then
            vu9.write(9867640, 1, 1, true)
        elseif not GG_InfinityAmmo.v then
            vu9.write(9867640, 0, 1, true)
        end
        if GG_FullSkills.v then
            local v398, v399, v400 = ipairs(vu202)
            while true do
                local v401
                v400, v401 = v398(v399, v400)
                if v400 == nil then
                    break
                end
                registerIntStat(v401, 1000)
            end
        elseif not GG_FullSkills.v then
            local v402, v403, v404 = ipairs(vu202)
            while true do
                local v405
                v404, v405 = v402(v403, v404)
                if v404 == nil then
                    break
                end
                local v406 = v404
                for v407 = 1, 7 do
                    local v408 = registerIntStat
                    local v409
                    if v406 == v407 then
                        v409 = _G["C" .. v407]
                    else
                        v409 = false
                    end
                    v408(v405, v409)
                end
            end
        end
        if GG_noCamRestore.v then
            vu9.write(5310892, 235, 1, true)
            vu9.write(5310917, 235, 1, true)
            vu9.write(5386662, 235, 1, true)
            vu9.write(5386797, 235, 1, true)
            vu9.write(5387194, 235, 1, true)
        else
            vu9.write(5310892, 122, 1, true)
            vu9.write(5310917, 122, 1, true)
            vu9.write(5386662, 117, 1, true)
            vu9.write(5386797, 117, 1, true)
            vu9.write(5387194, 117, 1, true)
        end
        if GG_NoReload.v then
            Bs = raknetNewBitStream()
            raknetBitStreamWriteInt32(Bs, getCurrentCharWeapon(PLAYER_PED))
            raknetBitStreamWriteInt32(Bs, 0)
            raknetEmulRpcReceiveBitStream(22, Bs)
            raknetDeleteBitStream(Bs)
        end
        if GG_NoSpread.v then
            vu9.setfloat(9252452, 0)
        elseif not GG_NoSpread.v then
            vu9.setfloat(9252452, pSpreadValue)
        end
        if GG_SensFix.v then
            writeMemory(11987992, 4, pFloatX, false)
        elseif not GG_SensFix.v then
            writeMemory(11987992, 4, pFloatY, false)
        end
        if GG_damager.v then
            local v410 = samp_create_sync_data("bullet")
            v410.targetType = 1
            v410.targetId = getClosestPlayerId()
            local v411 = v410.origin
            local v412 = v410.origin
            local v413 = v410.origin
            local v414, v415, v416 = getActiveCameraCoordinates()
            v413.z = v416
            v412.y = v415
            v411.x = v414
            v410.weaponId = getCurrentCharWeapon(PLAYER_PED)
            v410.send()
        end
        if GG_cdamage.v then
            local v417 = samp_create_sync_data("bullet")
            v417.targetType = 1
            v417.targetId = getClosestPlayerId()
            local v418 = v417.origin
            local v419 = v417.origin
            local v420 = v417.origin
            local v421, v422, v423 = getActiveCameraCoordinates()
            v420.z = v423
            v419.y = v422
            v418.x = v421
            v417.weaponId = 38
            v417.send()
        end
        if GG_Rapid.v then
            local v424, v425, v426 = pairs(pGunsAnimations)
            while true do
                local v427
                v426, v427 = v424(v425, v426)
                if v426 == nil then
                    break
                end
                setCharAnimSpeed(PLAYER_PED, v427, script.RapidSpeed.v)
            end
        elseif not GG_Rapid.v then
            local v428, v429, v430 = pairs(pGunsAnimations)
            while true do
                local v431
                v430, v431 = v428(v429, v430)
                if v430 == nil then
                    break
                end
                setCharAnimSpeed(PLAYER_PED, v431, 1)
            end
        end
        if GG_NameTags.v then
    for _, v241 in ipairs(getAllChars()) do
        if v241 ~= PLAYER_PED and isCharOnScreen(v241) then
            local v242, v243 = sampGetPlayerIdByCharHandle(v241)
            
            if v242 then -- Se o char for um player do SAMP
                -- Coordenadas 3D e conversão para Tela
                local v244, v245, v246 = getCharCoordinates(v241)
                local v247, v248 = convert3DCoordsToScreen(v244, v245, v246 + 1.1) -- Texto acima da cabeça
                
                -- Informações do Player
                local v250 = sampGetPlayerNickname(v243) .. " (" .. tostring(v243) .. ")"
                if sampIsPlayerPaused(v243) then
                    v250 = "{FFFF00}[AFK] {FFFFFF}" .. v250
                end
                
                local v251 = sampGetPlayerHealth(v243)
                local v252 = sampGetPlayerArmor(v243)
                
                -- Cálculo da cor (converte cor do SAMP para formato render)
                local v253 = bit.bor(bit.band(sampGetPlayerColor(v243), 0xFFFFFF), 0xFF000000)
                
                -- 1. Desenhar o Nome (Centralizado)
                local textWidth = renderGetFontDrawTextLength(fontwarp, v250)
                renderFontDrawText(fontwarp, v250, v247 - textWidth / 2, v248 - 35, v253)
                
                -- 2. Barra de Vida (HP)
                -- Fundo da barra
                renderDrawBoxWithBorder(v247 - 25, v248 - 20, 50, 5, 0xFF000000, 1, 0xFF000000)
                -- Preenchimento (Vida)
                local hpWidth = (v251 / 100) * 50 -- Proporcional a 50px
                if hpWidth > 50 then hpWidth = 50 end
                renderDrawBoxWithBorder(v247 - 25, v248 - 20, hpWidth, 5, 0xFFFF0000, 0, 0) -- Vermelho
                
                -- 3. Barra de Colete (AP) - Só desenha se tiver colete
                if v252 > 0 then
                    renderDrawBoxWithBorder(v247 - 25, v248 - 13, 50, 5, 0xFF000000, 1, 0xFF000000)
                    local apWidth = (v252 / 100) * 50
                    if apWidth > 50 then apWidth = 50 end
                    renderDrawBoxWithBorder(v247 - 25, v248 - 13, apWidth, 5, 0xFFFFFFFF, 0, 0) -- Branco/Cinza
                end
            end
        end
    end
end
        if GG_SkeletalWallHack.v then
            for v432 = 0, sampGetMaxPlayerId() do
                if sampIsPlayerConnected(v432) then
                    local v433, v434 = sampGetCharHandleBySampPlayerId(v432)
                    local v435 = sampGetPlayerColor(v432)
                    local _, v436, v437, v438 = explode_argb(v435)
                    local v439 = join_argb(255, v436, v437, v438)
                    if v433 then
                        if doesCharExist(v434) then
                            if isCharOnScreen(v434) then
                                local v440 = {
                                    3,
                                    4,
                                    5,
                                    51,
                                    52,
                                    41,
                                    42,
                                    31,
                                    32,
                                    33,
                                    21,
                                    22,
                                    23,
                                    2
                                }
                                for v441 = 1, # v440 do
                                    local v442, v443, v444 = getBodyPartCoordinates(v440[v441], v434)
                                    pos1Z = v444
                                    pos1Y = v443
                                    pos1X = v442
                                    local v445, v446, v447 = getBodyPartCoordinates(v440[v441] + 1, v434)
                                    pos2Z = v447
                                    pos2Y = v446
                                    pos2X = v445
                                    local v448, v449 = convert3DCoordsToScreen(pos1X, pos1Y, pos1Z)
                                    pos2 = v449
                                    pos1 = v448
                                    local v450, v451 = convert3DCoordsToScreen(pos2X, pos2Y, pos2Z)
                                    pos4 = v451
                                    pos3 = v450
                                    renderDrawLine(pos1, pos2, pos3, pos4, 2, v439)
                                end
                                for v452 = 4, 5 do
                                    local v453, v454, v455 = getBodyPartCoordinates(v452 * 10 + 1, v434)
                                    pos2Z = v455
                                    pos2Y = v454
                                    pos2X = v453
                                    local v456, v457 = convert3DCoordsToScreen(pos2X, pos2Y, pos2Z)
                                    pos4 = v457
                                    pos3 = v456
                                    renderDrawLine(pos1, pos2, pos3, pos4, 2, v439)
                                end
                                local v458 = {
                                    53,
                                    43,
                                    24,
                                    34,
                                    6
                                }
                                for v459 = 1, # v458 do
                                    local v460, v461, v462 = getBodyPartCoordinates(v458[v459], v434)
                                    posZ = v462
                                    posY = v461
                                    posX = v460
                                    local v463, v464 = convert3DCoordsToScreen(posX, posY, posZ)
                                    pos2 = v464
                                    pos1 = v463
                                end
                            end
                        end
                    end
                end
            end
        end
        if GG_espbox.v then
            local v465, v466, v467 = ipairs(getAllChars())
            while true do
                local v468
                v467, v468 = v465(v466, v467)
                if v467 == nil then
                    break
                end
                if v468 ~= playerPed and isCharOnScreen(v468) then
                    local v469 = {
                        getCharCoordinates(v468)
                    }
                    local v470 = {
                        convert3DCoordsToScreen(v469[1] + 0.3, v469[2] - 0.3, v469[3] - 1)
                    }
                    local v471 = {
                        convert3DCoordsToScreen(v469[1] + 0.3, v469[2] + 0.3, v469[3] - 1)
                    }
                    renderDrawLine(v471[1], v471[2], v470[1], v470[2], 2, sampGetPlayerColor(select(2, sampGetPlayerIdByCharHandle(v468))))
                    local v472 = {
                        convert3DCoordsToScreen(v469[1] + 0.3, v469[2] + 0.3, v469[3] + 1)
                    }
                    renderDrawLine(v471[1], v471[2], v472[1], v472[2], 2, sampGetPlayerColor(select(2, sampGetPlayerIdByCharHandle(v468))))
                    local v473 = {
                        convert3DCoordsToScreen(v469[1] + 0.3, v469[2] - 0.3, v469[3] + 1)
                    }
                    renderDrawLine(v472[1], v472[2], v473[1], v473[2], 2, sampGetPlayerColor(select(2, sampGetPlayerIdByCharHandle(v468))))
                    local v474 = {
                        convert3DCoordsToScreen(v469[1] + 0.3, v469[2] - 0.3, v469[3] - 1)
                    }
                    renderDrawLine(v473[1], v473[2], v474[1], v474[2], 2, sampGetPlayerColor(select(2, sampGetPlayerIdByCharHandle(v468))))
                    local v475 = {
                        convert3DCoordsToScreen(v469[1] - 0.3, v469[2] - 0.3, v469[3] - 1)
                    }
                    local v476 = {
                        convert3DCoordsToScreen(v469[1] + 0.3, v469[2] - 0.3, v469[3] - 1)
                    }
                    renderDrawLine(v476[1], v476[2], v475[1], v475[2], 2, sampGetPlayerColor(select(2, sampGetPlayerIdByCharHandle(v468))))
                    local v477 = {
                        convert3DCoordsToScreen(v469[1] - 0.3, v469[2] + 0.3, v469[3] - 1)
                    }
                    local v478 = {
                        convert3DCoordsToScreen(v469[1] + 0.3, v469[2] + 0.3, v469[3] - 1)
                    }
                    renderDrawLine(v477[1], v477[2], v478[1], v478[2], 2, sampGetPlayerColor(select(2, sampGetPlayerIdByCharHandle(v468))))
                    local v479 = {
                        convert3DCoordsToScreen(v469[1] - 0.3, v469[2] + 0.3, v469[3] + 1)
                    }
                    local v480 = {
                        convert3DCoordsToScreen(v469[1] + 0.3, v469[2] + 0.3, v469[3] + 1)
                    }
                    renderDrawLine(v479[1], v479[2], v480[1], v480[2], 2, sampGetPlayerColor(select(2, sampGetPlayerIdByCharHandle(v468))))
                    local v481 = {
                        convert3DCoordsToScreen(v469[1] - 0.3, v469[2] - 0.3, v469[3] + 1)
                    }
                    local v482 = {
                        convert3DCoordsToScreen(v469[1] + 0.3, v469[2] - 0.3, v469[3] + 1)
                    }
                    renderDrawLine(v481[1], v481[2], v482[1], v482[2], 2, sampGetPlayerColor(select(2, sampGetPlayerIdByCharHandle(v468))))
                    local v483 = {
                        convert3DCoordsToScreen(v469[1] - 0.3, v469[2] - 0.3, v469[3] - 1)
                    }
                    local v484 = {
                        convert3DCoordsToScreen(v469[1] - 0.3, v469[2] + 0.3, v469[3] - 1)
                    }
                    renderDrawLine(v484[1], v484[2], v483[1], v483[2], 2, sampGetPlayerColor(select(2, sampGetPlayerIdByCharHandle(v468))))
                    local v485 = {
                        convert3DCoordsToScreen(v469[1] - 0.3, v469[2] + 0.3, v469[3] + 1)
                    }
                    renderDrawLine(v484[1], v484[2], v485[1], v485[2], 2, sampGetPlayerColor(select(2, sampGetPlayerIdByCharHandle(v468))))
                    local v486 = {
                        convert3DCoordsToScreen(v469[1] - 0.3, v469[2] - 0.3, v469[3] + 1)
                    }
                    renderDrawLine(v485[1], v485[2], v486[1], v486[2], 2, sampGetPlayerColor(select(2, sampGetPlayerIdByCharHandle(v468))))
                    local v487 = {
                        convert3DCoordsToScreen(v469[1] - 0.3, v469[2] - 0.3, v469[3] - 1)
                    }
                    renderDrawLine(v486[1], v486[2], v487[1], v487[2], 2, sampGetPlayerColor(select(2, sampGetPlayerIdByCharHandle(v468))))
                end
            end
        end
        if GG_esplines.v then
            local v488 = {
                getCharCoordinates(playerPed)
            }
            local v489, v490, v491 = ipairs(getAllChars())
            while true do
                local v492
                v491, v492 = v489(v490, v491)
                if v491 == nil then
                    break
                end
                local v493, v494 = sampGetPlayerIdByCharHandle(v492)
                if v493 and (v492 ~= playerPed and isCharOnScreen(v492)) then
                    local v495 = {
                        getCharCoordinates(v492)
                    }
                    local v496, v497, v498, _, _, _ = convert3DCoordsToScreenEx(v488[1], v488[2], v488[3], true, true)
                    local v499, v500, v501, _, _, _ = convert3DCoordsToScreenEx(v495[1], v495[2], v495[3], true, true)
                    if v496 and v499 then
                        renderDrawLine(v497, v498, v500, v501, 1 == 0 and 1 or 2, sampGetPlayerColor(v494))
                    end
                end
            end
        end
        if GG_ESPVEICULOS.v then
            local veh = getAllVehicles() or {}
            for k, v in ipairs(veh) do
                if isCarOnScreen(v) then
                    local carModel = getCarModel(v)
                    local carIndex = (carModel and (carModel - 399)) or nil
                    local modelName = (type(cars) == "table" and carIndex and cars[carIndex]) and cars[carIndex] or tostring(carModel)
                    local model = modelName .. ' (' .. tostring(select(2, sampGetVehicleIdByCarHandle(v))) .. ')'
                    local clr1, clr2 = 0, 0
                    if pcall(getCarColours, v) then
                        clr1, clr2 = getCarColours(v)
                    end
                    local clr = clr1 or clr2 or 0
                    local cx, cy, cz = getCarCoordinates(v)
                    local x, y = convert3DCoordsToScreen(cx, cy, cz)
                    local length = renderGetFontDrawTextLength(font, model, true)
                    local height = renderGetFontDrawHeight(font)
                    local textcolor = 0xFF00B811
                    if getCarDoorLockStatus(v) == 2 then
                        textcolor = 0xFFEC0000
                    end
                    renderFontDrawText(font, model, x - (length + 5 + 18) / 2, y - (height + 7 + 14) / 2, textcolor, true)
                    renderDrawBox(x + (length + 5 - 18) / 2, y - (7 + 14) / 2 - 9, 18, 18, 0xFFFFFFFF)
                    local colorval = (type(colors) == "table" and colors[clr + 1]) and colors[clr + 1] or 0xFF000000
                    renderDrawBox(x + (length + 5 - 18) / 2 + 2, y - (7 + 14) / 2 - 7, 14, 14, 0xFF000000 + (colorval / 0x100))
                    local healthbox = length + 5 + 18 + 8
                    local carHealth = pcall(getCarHealth, v) and getCarHealth(v) or 0
                    local healthbox2 = healthbox * (carHealth / 1000)
                    renderDrawBox(x - healthbox / 2 - 1, y + (height + 7 - 14) / 2, healthbox + 2, 14, 0xFF000000)
                    renderDrawBox(x - healthbox / 2, y + (height + 7 - 14) / 2 + 1, healthbox, 12, 0xFF0084DF)
                    renderDrawBox(x - healthbox / 2, y + (height + 7 - 14) / 2 + 1, healthbox2, 12, 0xFF005C9B)
                end
            end
        end
        if GG_DisableUnderWaterEffects.v then
            DisableUnderWaterEffects(true)
        elseif not GG_DisableUnderWaterEffects.v then
            DisableUnderWaterEffects(false)
        end
        if GG_DisableWater.v then
            DisableWater(true)
        elseif not GG_DisableWater.v then
            DisableWater(false)
        end
        if teleporter.quick_teleport.v == true and (isKeyDown(keys.quick_teleport1) and isKeyDown(keys.quick_teleport2)) then
            Teleport()
        end
        if GG_objectwallhack.v then
            local v502, v503, v504 = pairs(getAllObjects())
            while true do
                local v505
                v504, v505 = v502(v503, v504)
                if v504 == nil then
                    break
                end
                if sampGetObjectSampIdByHandle(v505) ~= - 1 then
                    sampGetObjectSampIdByHandle(v505)
                end
                if isObjectOnScreen(v505) then
                    local _, v506, v507, v508 = getObjectCoordinates(v505)
                    local v509, v510 = convert3DCoordsToScreen(v506, v507, v508)
                    local v511 = getObjectModel(v505)
                    local v512, v513, v514 = getCharCoordinates(PLAYER_PED)
                    local v515, v516 = convert3DCoordsToScreen(v512, v513, v514)
                    local v517 = string.format("%.1f", getDistanceBetweenCoords3d(v506, v507, v508, v512, v513, v514))
                    if GG_objectwallhack.v then
                        local v518, v519, v520 = ipairs(ObjectFinder_Table)
                        while true do
                            local v521
                            v520, v521 = v518(v519, v520)
                            if v520 == nil then
                                break
                            end
                            if v521[1].v == v511 then
                                if v521[1].v ~= 1212 then
                                    if v521[1].v ~= 1276 then
                                        if v521[1].v ~= 1240 then
                                            if v521[1].v ~= 1241 then
                                                if v521[1].v ~= 11736 then
                                                    if v521[1].v ~= 11738 then
                                                        if v521[1].v ~= 19941 then
                                                            if v521[1].v ~= 1247 then
                                                                MODEL_TEXT = "{FF5656}< {ffffff}model = {FF5656}" .. v511 .. "\n{ffffff}distance: {FF5656}" .. v517
                                                            else
                                                                MODEL_TEXT = "{FF5656}< {fc9803}Bribe\n{ffffff}distance: {FF5656}" .. v517
                                                            end
                                                        else
                                                            MODEL_TEXT = "{FF5656}< {ffc800}Gold Bar\n{ffffff}distance: {FF5656}" .. v517
                                                        end
                                                    else
                                                        MODEL_TEXT = "{FF5656}< {e80000}Medic Case\n{ffffff}distance: {FF5656}" .. v517
                                                    end
                                                else
                                                    MODEL_TEXT = "{FF5656}< {e80000}Medical Satchel\n{ffffff}distance: {FF5656}" .. v517
                                                end
                                            else
                                                MODEL_TEXT = "{FF5656}< {e80000}Adrenaline\n{ffffff}distance: {FF5656}" .. v517
                                            end
                                        else
                                            MODEL_TEXT = "{FF5656}< {e80000}Health\n{ffffff}distance: {FF5656}" .. v517
                                        end
                                    else
                                        MODEL_TEXT = "{FF5656}< {9f00e8}Package\n{ffffff}distance: {FF5656}" .. v517
                                    end
                                else
                                    MODEL_TEXT = "{FF5656}< {04e800}Money\n{ffffff}distance: {FF5656}" .. v517
                                end
                                renderFontDrawText(font, MODEL_TEXT, v509, v510, - 1)
                                if GG_objtraser.v then
                                    renderDrawLine(v515, v516, v509, v510, 1, - 1)
                                end
                            end
                        end
                    end
                end
            end
        end
        if GG_SUN.v then
            Sun()
        end
        if GG_WetRoads.v then
            vu9.fill(7519135, 144, 12, true)
            vu9.fill(7519147, 144, 20, true)
            vu9.fill(7519179, 144, 12, true)
            vu9.fill(7518528, 144, 5, true)
            vu9.fill(7518507, 144, 5, true)
            vu9.fill(7518553, 144, 5, true)
        end
        if GG_SandParticle.v then
            vu9.fill(6990031, 144, 53, true)
        end
        if GG_BladeCollision.v then
            vu9.fill(7098631, 144, 59, true)
        end
        if GG_SpeedLimit.v then
            vu9.fill(5524720, 144, 14, true)
        end
        if GG_RailsResistance.v then
            vu9.setfloat(9254060, 0, true)
        end
        if GG_SpawnFix.v then
            vu9.fill(4331508, 144, 21, true)
            vu9.fill(4331736, 144, 17, true)
            vu9.fill(6258880, 144, 10, true)
            vu9.fill(6273607, 144, 10, true)
        end
        if GG_PauseMenuFix.v then
            local v522 = vu9.unprotect(7635043, 5)
            vu9.hex2bin("E8F83BDFFF", 7635043, 5)
            vu9.protect(7635043, 5, v522)
        end
        if GG_HydraSniper.v and isPlayerPlaying(PLAYER_HANDLE) then
            local v523 = {
                getCharCoordinates(PLAYER_PED)
            }
            local v524, v525 = findAllRandomVehiclesInSphere(v523[1], v523[2], v523[3], 10, true, true)
            if v524 then
                local v526 = getCarModel(v525)
                if (v526 == 520 or v526 == 425) and getPadState(PLAYER_HANDLE, 15) == 255 then
                    setCurrentCharWeapon(PLAYER_PED, 0)
                end
            end
        end
        if GG_ClickMap.v and id == 119 then
            local v527 = raknetBitStreamReadFloat(bs)
            local v528 = raknetBitStreamReadFloat(bs)
            local v529 = raknetBitStreamReadFloat(bs)
            requestCollision(v527, v528)
            loadScene(v527, v528, v529)
            local v530, v531, v532, v533 = getTargetBlipCoordinates()
            if v530 then
                local v534 = raknetNewBitStream()
                raknetBitStreamWriteFloat(v534, v531)
                raknetBitStreamWriteFloat(v534, v532)
                raknetBitStreamWriteFloat(v534, v533 + 0.5)
                raknetSendRpcEx(119, v534, priority, reliability, channel, shiftTimestamp)
                raknetDeleteBitStream(v534)
            end
            return false
        end
        if GG_AirCraftExplosionFix.v then
            vu9.setuint32(7565192, 0, true)
        end
        if GG_FPS.v then
            vu9.write(sampGetBase() + 645584, 1347550997, 4, true)
            vu9.write(12235544, 0, 1, true)
            vu9.write(5499212, 0, 1, true)
        end
        if GG_blur.v then
            writeMemory(7360138, 1, 232, true)
            writeMemory(7360139, 1, 17, true)
            writeMemory(7360140, 1, 226, true)
            writeMemory(7360141, 1, 255, true)
            writeMemory(7360142, 1, 255, true)
        end
        if GG_fpsboost.v then
            vu9.write(7358318, 2866, 4, false)
            vu9.write(7358314, - 380152237, 4, false)
        elseif not GG_fpsboost.v then
            vu9.write(7358318, 1448280247, 4, false)
            vu9.write(7358314, - 988281383, 4, false)
        end
        if GG_fixwater.v then
            vu9.setfloat(13101856, 0, false)
            vu9.write(7249056, 13101856, 4, false)
            vu9.write(7249115, 13101856, 4, false)
            vu9.write(7249175, 13101856, 4, false)
            vu9.write(7249235, 13101856, 4, false)
        elseif not GG_fixwater.v then
            vu9.write(7249056, 8752012, 4, false)
            vu9.write(7249115, 8752012, 4, false)
            vu9.write(7249175, 8752012, 4, false)
            vu9.write(7249235, 8752012, 4, false)
        end
        if GG_anticrasher.v then
            vu9.write(sampGetBase() + 380716, 2425393296, 4, true)
            vu9.write(sampGetBase() + 380716 + 4, 144, 1, true)
            vu9.write(sampGetBase() + 380716 + 4 + 9, 2425393296, 4, true)
            vu9.write(sampGetBase() + 380716 + 4 + 9 + 4, 144, 1, true)
        elseif not GG_anticrasher.v then
            vu9.write(sampGetBase() + 380716, 7729128, 4, true)
            vu9.write(sampGetBase() + 380716 + 4, 0, 1, true)
            vu9.write(sampGetBase() + 380716 + 4 + 9, 2097870979, 4, true)
            vu9.write(sampGetBase() + 380716 + 4 + 9 + 4, 14, 1, true)
        end
        if GG_fmoney.v then
            vu9.write(5707667, 137, 1, false)
        elseif not GG_fmoney.v then
            vu9.write(5707667, 139, 1, false)
        end
        if GG_lmap.v then
            vu9.write(6359759, 144, 1, false)
            vu9.write(6359760, 144, 1, false)
            vu9.write(6359761, 144, 1, false)
            vu9.write(6359762, 144, 1, false)
            vu9.write(6359763, 144, 1, false)
            vu9.write(6359764, 144, 1, false)
            vu9.write(6359778, 144, 1, false)
            vu9.write(6359779, 144, 1, false)
            vu9.write(6359780, 144, 1, false)
            vu9.write(6359781, 144, 1, false)
            vu9.write(6359782, 144, 1, false)
            vu9.write(6359783, 144, 1, false)
            vu9.write(6359784, 144, 1, false)
            vu9.write(6359785, 144, 1, false)
            vu9.write(6359786, 144, 1, false)
            vu9.write(6359787, 144, 1, false)
            vu9.write(5637016, 12044024, 4, false)
            vu9.write(5637032, 12044024, 4, false)
            vu9.write(5637048, 12044024, 4, false)
            vu9.write(5636920, 12044048, 4, false)
            vu9.write(5636936, 12044072, 4, false)
            vu9.write(5636952, 12044096, 4, false)
            vu9.setfloat(9228384, 0.8, false)
            vu9.setfloat(12044024, 0.8, false)
            vu9.setfloat(12044048, 0.8, false)
            vu9.setfloat(12044072, 0.8, false)
            vu9.setfloat(12044096, 0.8, false)
        elseif not GG_lmap.v then
            vu9.write(6359759, 217, 1, false)
            vu9.write(6359760, 21, 1, false)
            vu9.write(6359761, 96, 1, false)
            vu9.write(6359762, 208, 1, false)
            vu9.write(6359763, 140, 1, false)
            vu9.write(6359764, 0, 1, false)
            vu9.write(6359778, 199, 1, false)
            vu9.write(6359779, 5, 1, false)
            vu9.write(6359780, 96, 1, false)
            vu9.write(6359781, 208, 1, false)
            vu9.write(6359782, 140, 1, false)
            vu9.write(6359783, 0, 1, false)
            vu9.write(6359784, 0, 1, false)
            vu9.write(6359785, 0, 1, false)
            vu9.write(6359786, 128, 1, false)
            vu9.write(6359787, 63, 1, false)
            vu9.write(5637016, 12043448, 4, false)
            vu9.write(5637032, 12043452, 4, false)
            vu9.write(5637048, 12043456, 4, false)
            vu9.write(5636920, 12043424, 4, false)
            vu9.write(5636936, 12043428, 4, false)
            vu9.write(5636952, 12043432, 4, false)
        end
        if GG_MEMORY.v then
            writeMemory(9067136, 4, script.pMemory.v * 1048576, true)
        elseif not GG_MEMORY.v then
            writeMemory(9067136, 4, 536870912, true)
        end
        if GG_CMEM.v and tonumber(get_memory()) > tonumber(script.pMemSize.v) then
            CleanMemory()
        end
        if GG_DrawDist.v then
        end
        if GG_FogDist.v then
        end
        if GG_LogDist.v then
            vu9.setfloat(8753112, script.pLogEdit.v, false)
        elseif not GG_LogDist.v then
            vu9.setfloat(8753112, 500, false)
        end
        if GG_Time.v then
            vu9.setint8(11993427, tonumber(script.pTime.v), true)
        end
        if GG_Weather.v then
            vu9.setint8(13112096, tonumber(script.pWeather.v), true)
        end
        if GG_Fovedit.v then
            cameraSetLerpFov(script.pFovedit.v, script.pFovedit.v, 999988888, true)
        end
        if GG_camshake.v then
            shakeCam(script.pCamshake.v)
        end
        if GG_trigger.v and isKeyDown(VK_RBUTTON) then
            local v535, v536, v537 = getActiveCameraCoordinates()
            local v538, v539 = convertGameScreenCoordsToWindowScreenCoords(339.1, 179.1)
            local v540, v541, v542 = convertScreenCoordsToWorld3D(v538, v539, 50)
            local v543, v544 = processLineOfSight(v535, v536, v537, v540, v541, v542, false, false, true, false, false, false, false)
            if v543 and (isLineOfSightClear(v535, v536, v537, v544.pos[1], v544.pos[2], v544.pos[3], true, true, false, true, true) and (v544.entityType == 3 and (getCharPointerHandle(v544.entity) ~= playerPed and vu194.clock() - vu203 > 0))) then
                vu203 = vu194.clock()
                writeMemory(12006522, 4, 255, 0)
            end
        end
        if GG_gtavaim.v then
            local v545 = {
                convertGameScreenCoordsToWindowScreenCoords(339.1, 179.1)
            }
            if not isCharSittingInAnyCar(PLAYER_PED) and (not isCharInAnyTrain(PLAYER_PED) and (not isCharSwimming(PLAYER_PED) and isKeyDown(VK_RBUTTON))) then
                wp = getCurrentCharWeapon(playerPed)
                if wp == 22 or (wp == 23 or (wp == 24 or (wp == 25 or (wp == 26 or (wp == 27 or (wp == 28 or (wp == 29 or (wp == 32 or (wp == 30 or (wp == 31 or (wp == 33 or wp == 38))))))))))) then
                    local v546, v547 = getCharPlayerIsTargeting(playerHandle)
                    ped = v547
                    result = v546
                    if result then
                        changeCrosshairColor(join_argb(0, 0, 0, 0))
                        renderDrawBoxWithBorder(v545[1] - 1.5, v545[2] - 1.5, 3, 3, 4294901760, 0, 4294901760)
                    else
                        changeCrosshairColor(join_argb(0, 0, 0, 0))
                        renderDrawBoxWithBorder(v545[1] - 1.5, v545[2] - 1.5, 3, 3, 4294967295, 0, 4294967295)
                    end
                end
            end
        else
            changeCrosshairColor(join_argb(255, 255, 255, 255))
        end
        if GG_AimBot.v then
            if script.aimbot_type.v ~= 0 then
                if script.aimbot_type.v ~= 1 then
                    if isKeyDown(VK_RBUTTON) then
                        local v548 = GetNearestPed()
                        if v548 ~= - 1 then
                            if aimbot.disabledOnAnim.v then
                                animationPlaying()
                            end
                            local v549, v550 = sampGetPlayerIdByCharHandle(playerPed)
                            if v549 then
                                sampGetPlayerColor(v550)
                                sampGetPlayerColor(v548)
                                if aimbot.disabledIfFriend.v then
                                    local _ = sampGetPlayerColor(v550) ~= sampGetPlayerColor(v548)
                                end
                                sampGetPlayerIdByCharHandle(playerPed)
                                local v551, v552 = sampGetCharHandleBySampPlayerId(v548)
                                local v553 = {
                                    getActiveCameraCoordinates()
                                }
                                if v551 then
                                    if aimbot.skipDead.v then
                                        isCharDead(v552)
                                    end
                                    if aimbot.disabledOnAFk.v then
                                        sampIsPlayerPaused(v548)
                                    end
                                    local v554 = {
                                        getBodyPartCoordinates(GetNearestBone(v552), v552)
                                    }
                                    if isLineOfSightClear(v553[1], v553[2], v553[3], v554[1], v554[2], v554[3], true, true, false, true, true) then
                                        local v555 = getCurrentCharWeapon(playerPed)
                                        if v555 ~= 0 then
                                            if (v555 < 22 or v555 > 29) and v555 ~= 32 then
                                                if v555 == 30 or v555 == 31 then
                                                    coefficent = 0.028
                                                elseif v555 == 33 then
                                                    coefficent = 0.01897
                                                end
                                            else
                                                coefficent = 0.04253
                                            end
                                            local v556 = {
                                                v553[1] - v554[1],
                                                v553[2] - v554[2]
                                            }
                                            local v557 = math.acos(v556[1] / math.sqrt(math.pow(v556[1], 2) + math.pow(v556[2], 2)))
                                            local v558 = {
                                                fix(representIntAsFloat(readMemory(11989592, 4, false))),
                                                fix(representIntAsFloat(readMemory(11989576, 4, false)))
                                            }
                                            if v556[1] <= 0 and v556[2] >= 0 or v556[1] >= 0 and v556[2] >= 0 then
                                                dif = v557 + coefficent - v558[1]
                                            end
                                            if v556[1] >= 0 and v556[2] <= 0 or v556[1] <= 0 and v556[2] <= 0 then
                                                dif = - v557 + coefficent - v558[1]
                                            end
                                            local v559 = dif / (aimbot.smoothSpeed.v * 5 * aimbot.addSmoothSpeed.v)
                                            if v559 <= 0 then
                                                if - v559 < - vu204 then
                                                    v559 = v559 * (- vu204 / - v559)
                                                end
                                            elseif v559 < vu204 then
                                                v559 = v559 * (vu204 / v559)
                                            end
                                            vu204 = v559
                                            if v559 > - 1 and (v559 < 0.5 and (dif > - 2 and dif < 2)) then
                                                v558[1] = v558[1] + v559
                                                setCameraPositionUnfixed(v558[2], v558[1])
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                elseif getCurrentCharWeapon(playerPed) ~= 0 and isKeyDown(VK_RBUTTON) then
                    local v560 = GetNearestPed()
                    if v560 ~= - 1 then
                        local v561, v562 = sampGetCharHandleBySampPlayerId(v560)
                        if v561 and (doesCharExist(v562) and not isCharInAnyCar(v562)) then
                            if aimbot.proSkipDead.v then
                                isCharDead(v562)
                            end
                            if v562 ~= playerPed then
                                local v563 = {
                                    getCharCoordinates(playerPed)
                                }
                                local v564, v565, _ = getActiveCameraCoordinates()
                                local v566, v567, _ = getActiveCameraPointAt()
                                local v568 = getCharHeading(playerPed)
                                local v569 = getHeadingFromVector2d(v566 - v564, v567 - v565)
                                setCharCoordinates(v562, v563[1] + math.sin(- math.rad(v569)) * 1.1 + math.sin(- math.rad(v569)) / 2 - 0.3 * math.sin(- math.rad(v569 + 90)), v563[2] + math.cos(- math.rad(v569)) * 1.1 + math.cos(- math.rad(v569)) / 2 - 0.3 * math.cos(- math.rad(v569 + 90)), v563[3] - 0.6)
                                setCharHeading(v562, v568)
                            end
                        end
                    end
                end
            else
                local v570, v571 = getCharPlayerIsTargeting(playerHandle)
                if v570 then
                    local _, v572 = sampGetPlayerIdByCharHandle(v571)
                    local v573 = {
                        getActiveCameraCoordinates()
                    }
                    local v574 = {
                        getCharCoordinates(v571)
                    }
                    local v575 = {
                        v573[1] - v574[1],
                        v573[2] - v574[2],
                        v573[3] - v574[3]
                    }
                    if isWidescreenOnInOptions() then
                        coefficentZ = 0.0778
                    else
                        coefficentZ = 0.103
                    end
                    local v576 = {
                        math.atan2(v575[2], v575[1]) + 0.04253,
                        math.atan2(math.sqrt(math.pow(v575[1], 2) + math.pow(v575[2], 2)), v575[3]) - math.pi / 2 - coefficentZ
                    }
                    local v577 = {
                        fix(representIntAsFloat(readMemory(11989592, 4, false))),
                        fix(representIntAsFloat(readMemory(11989576, 4, false)))
                    }
                    local v578 = {
                        v576[1] - v577[1],
                        v576[2] - v577[2]
                    }
                    local v579 = {
                        v578[1] / 1,
                        v578[2] / 1
                    }
                    if aimbot.team_ignore.v then
                        local _, v580 = sampGetPlayerIdByCharHandle(PLAYER_PED)
                        if "" .. string.gsub(("%X"):format(sampGetPlayerColor(v572)), "..(......)", "%1") .. "" ~= "" .. string.gsub(("%X"):format(sampGetPlayerColor(v580)), "..(......)", "%1") .. "" then
                            setCameraPositionUnfixed(v577[2] + v579[2], v577[1] + v579[1])
                        end
                    else
                        setCameraPositionUnfixed(v577[2] + v579[2], v577[1] + v579[1])
                    end
                end
            end
        end
        if GG_WaterX.v and GG_rWater.v then
            local v581, v582, v583, v584 = rainbow(script.pWaterSpeed.v, 1, 120)
            changeWaterColorRGB(v581, v582, v583, v584)
        end
        if not GG_rWater.v and GG_WaterX.v then
            changeWaterColorRGB(WATER_RPG.v[1] * 255, WATER_RPG.v[2] * 255, WATER_RPG.v[3] * 255, WATER_RPG.v[4] * 255)
        end
        if not GG_WaterX.v then
            changeWaterColorRGB(0, 194, 255)
        end
        if GG_ObjectCollision.v then
            local v585, v586 = findAllRandomObjectsInSphere(pPlayerPosX, pPlayerPosY, pPlayerPosZ, 10, 1)
            if v585 and v586 > 0 then
                setObjectCollision(v586, false)
            end
        end
        if GG_bypasstpadm.v then
            function v13.onSetPlayerPos()
                return false
            end
        elseif GG_bypasstpadm.v == false then
            function v13.onSetPlayerPos()
                return true
            end
        end
        if GG_tutorial.v then
            function v13.onSetPlayerPos()
                return false
            end
        elseif GG_tutorial.v == false then
            function v13.onSetPlayerPos()
                return true
            end
        end
        if GG_pararjogadores.v then
            local v255 = 2000
            local v256 = nil
            local v257 = nil
            local v258 = nil
            if GG_telagem.v and tvActive then
                local _, v259 = sampGetCharHandleBySampPlayerId(id)
                if v259 and doesCharExist(v259) then
                    v256, v257, v258 = getCharCoordinates(v259)
                end
            else
                v256, v257, v258 = getCharCoordinates(PLAYER_PED)
            end
            if v256 then
                local v260, v261 = findAllRandomCharsInSphere(v256, v257, v258, 5, true, false)
                if v260 and v261 ~= PLAYER_PED then
                    local v262, v263 = sampGetPlayerIdByCharHandle(v261)
                    if v262 and v263 ~= select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) then
                        for _ = 1, 3 do
                            sampSendChat("/mostrarrg " .. v263)
                            printStringNow("PARANDO JOGADOR " .. v263, 250)
                            wait(v255)
                        end
                    end
                end
            end
        end
        if GG_BlockDrugsAnimation.v then
            local v587, v588, v589 = pairs(pOverdoseAnimations)
            while true do
                local v590
                v589, v590 = v587(v588, v589)
                if v589 == nil then
                    break
                end
                if isCharPlayingAnim(PLAYER_PED, v590) then
                    clearCharTasksImmediately(PLAYER_PED)
                end
            end
        end
        if GG_OVERHP.v then
            vu9.setfloat(12030944, 910.4)
        elseif not GG_OVERHP.v then
            vu9.setfloat(12030944, 569)
        end
        if GG_RPName.v then
            nickname = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
            if nickname:match("%w+_%w+") then
                sampSetLocalPlayerName(nickname:gsub("_", " "))
            end
        end
        if GG_ChecarDroides.v then
            local peds = getAllChars()
            for i=1, #peds do
                local ped = peds[i]
                if ped ~= PLAYER_PED and isCharOnScreen(ped) then
                    local result, id = sampGetPlayerIdByCharHandle(ped)
                    if result and not sampIsPlayerNpc(id) then
                        local x, y, z = getCharCoordinates(ped)
                        local xs, ys = convert3DCoordsToScreen(x, y, z)
                        if players_device[id] then
                            if players_device[id] == "Mobile" then
                                renderFontDrawText(font_device, "MOBILE", xs - 23, ys, 0xFF00FFC9)
                            else
                                renderFontDrawText(font_device, "PC", xs - 23, ys, 0xFFFF0000)
                            end
                        end
                    end
                end
            end
        end
        wait(0)
        if script.activekey.v ~= 0 then
            if script.activekey.v ~= 1 then
                if script.activekey.v ~= 2 then
                    if wasKeyPressed(vu12.VK_END) then
                        DrawTheMenu()
                    end
                elseif wasKeyPressed(vu12.VK_HOME) then
                    DrawTheMenu()
                end
            elseif wasKeyPressed(vu12.VK_DELETE) then
                DrawTheMenu()
            end
        elseif wasKeyPressed(vu12.VK_INSERT) then
            DrawTheMenu()
        end
        vu200.Process = script.window.v or (script.iHUD.v or script.vHUD.v) or (script.cHUD.v or script.StaminaHUD.v or (script.sms_window.v or script.admin_panel.v))
    end
    while isKeyDown(keys.quick_teleport1) and isKeyDown(keys.quick_teleport2) do
        wait(0)
    end
    Teleport()
	
end
function fix(p591)
    while math.pi < p591 do
        p591 = p591 - math.pi * 2
    end
    while p591 < - math.pi do
        p591 = p591 + math.pi * 2
    end
    return p591
end
function animationPlaying()
    local v592, v593, v594 = pairs(packet_animation)
    while true do
        local v595
        v594, v595 = v592(v593, v594)
        if v594 == nil then
            break
        end
        if isCharPlayingAnim(playerPed, v595) then
            return false
        end
    end
    return true
end
function getBodyPartCoordinates(p596, p597)
    if doesCharExist(p597) then
        local v598 = getCharPointer(p597)
        local v599 = vu198.new("float[3]")
        vu11(vu198.cast("void*", v598), v599, p596, true)
        return v599[0], v599[1], v599[2]
    end
end
function GetNearestPed()
    local v600 = 20000
    local v601 = - 1
    for v602 = 0, sampGetMaxPlayerId(true) do
        if sampIsPlayerConnected(v602) then
            local v603, v604 = sampGetCharHandleBySampPlayerId(v602)
            if v603 then
                if isCharOnScreen(v604) then
                    local v605 = {
                        convertGameScreenCoordsToWindowScreenCoords(339.1, 179.1)
                    }
                    local v606 = {
                        getBodyPartCoordinates(GetNearestBone(v604), v604)
                    }
                    local v607 = {
                        convert3DCoordsToScreen(v606[1], v606[2], v606[3])
                    }
                    local v608 = math.sqrt(math.pow(v607[1] - v605[1], 2) + math.pow(v607[2] - v605[2], 2))
                    if v608 < aimbot.safeZone.v or aimbot.jobRadius.v < v608 then
                        check = true
                    else
                        check = false
                    end
                    if not check then
                        local v609 = {
                            getCharCoordinates(playerPed)
                        }
                        local v610 = {
                            getCharCoordinates(v604)
                        }
                        local v611 = math.sqrt(math.pow(v610[1] - v609[1], 2) + math.pow(v610[2] - v609[2], 2) + math.pow(v610[3] - v609[3], 2))
                        if v611 < v600 then
                            v601 = v602
                            v600 = v611
                        end
                    end
                end
            end
        end
    end
    return v601
end
function GetNearestBone(p612)
    bone = {
        42,
        52,
        23,
        33,
        3,
        22,
        32,
        8
    }
    local v613 = 20000
    local v614 = - 1
    for v615 = 1, 8 do
        local v616 = {
            convertGameScreenCoordsToWindowScreenCoords(339.1, 179.1)
        }
        local v617 = {
            getBodyPartCoordinates(bone[v615], p612)
        }
        local v618 = {
            convert3DCoordsToScreen(v617[1], v617[2], v617[3])
        }
        local v619 = math.sqrt(math.pow(v618[1] - v616[1], 2) + math.pow(v618[2] - v616[2], 2))
        if v619 < v613 then
            v614 = bone[v615]
            v613 = v619
        end
    end
    return v614
end
function getCarNamebyModel(modelId)
    local carNames = {
        [400] = "Landstalker",[401] = "Bravura",[402] = "Buffalo",[403] = "Linerunner",[404] = "Perennial",[405] = "Sentinel",[406] = "Dumper",[407] = "Firetruck",[408] = "Trashmaster",[409] = "Stretch",[410] = "Manana",[411] = "Infernus",[412] = "Voodoo",[413] = "Pony",[414] = "Mule",[415] = "Cheetah",[416] = "Ambulance",[417] = "Leviathan",[418] = "Moonbeam",[419] = "Esperanto",[420] = "Taxi",[421] = "Washington",[422] = "Bobcat",[423] = "Mr. Whoopee",[424] = "BF Injection",[425] = "Hunter",[426] = "Premier",[427] = "Enforcer",[428] = "Securicar",[429] = "Banshee",[430] = "Predator",[431] = "Bus",[432] = "Rhino",[433] = "Barracks",[434] = "Hotknife",[435] = "Article Trailer",[436] = "Previon",[437] = "Coach",[438] = "Cabbie",[439] = "Stallion",[440] = "Rumpo",[441] = "RC Bandit",[442] = "Romero",[443] = "Packer",[444] = "Monster",[445] = "Admiral",[446] = "Squallo",[447] = "Seaspamrow",[448] = "Pizzaboy",[449] = "Tram",[450] = "Article Trailer 2",[451] = "Turismo",[452] = "Speeder",[453] = "Reefer",[454] = "Tropic",[455] = "Flatbed",[456] = "Yankee",[457] = "Caddy",[458] = "Solair",[459] = "Topfun Van",[460] = "Skimmer",[461] = "PCJ-600",[462] = "Faggio",[463] = "Freeway",[464] = "RC Baron",[465] = "RC Raider",[466] = "Glendale",[467] = "Oceanic",[468] = "Sanchez",[469] = "Spamrow",[470] = "Patriot",[471] = "Quad",[472] = "Coastguard",[473] = "Dinghy",[474] = "Hermes",[475] = "Sabre",[476] = "Rustler",[477] = "ZR-350",[478] = "Walton",[479] = "Regina",[480] = "Comet",[481] = "BMX",[482] = "Burrito",[483] = "Camper",[484] = "Marquis",[485] = "Baggage",[486] = "Dozer",[487] = "Maverick",[488] = "News Maverick",[489] = "Rancher",[490] = "FBI Rancher",[491] = "Virgo",[492] = "Greenwood",[493] = "Jetmax",[494] = "Hotring Racer",[495] = "Sandking",[496] = "Blista Compact",[497] = "Police Maverick",[498] = "Boxville",[499] = "Benson",[500] = "Mesa",[501] = "RC Goblin",[502] = "Hotring Racer A",[503] = "Hotring Racer B",[504] = "Bloodring Banger",[505] = "Rancher",[506] = "Super GT",[507] = "Elegant",[508] = "Journey",[509] = "Bike",[510] = "Mountain Bike",[511] = "Beagle",[512] = "Cropduster",[513] = "Stuntplane",[514] = "Tanker",[515] = "Roadtrain",[516] = "Nebula",[517] = "Majestic",[518] = "Buccaneer",[519] = "Shamal",[520] = "Hydra",[521] = "FCR-900",[522] = "NRG-500",[523] = "HPV1000",[524] = "Cement Truck",[525] = "Towtruck",[526] = "Fortune",[527] = "Cadrona",[528] = "FBI Truck",[529] = "Willard",[530] = "Forklift",[531] = "Tractor",[532] = "Combine",[533] = "Feltzer",[534] = "Remington",[535] = "Slamvan",[536] = "Blade",[537] = "Train",[538] = "Train",[539] = "Vortex",[540] = "Vincent",[541] = "Bullet",[542] = "Clover",[543] = "Sadler",[544] = "Firetruck",[545] = "Hustler",[546] = "Intruder",[547] = "Primo",[548] = "Cargobob",[549] = "Tampa",[550] = "Sunrise",[551] = "Merit",[552] = "Utility Van",[553] = "Nevada",[554] = "Yosemite",[555] = "Windsor",[556] = "Monster A",[557] = "Monster B",[558] = "Uranus",[559] = "Jester",[560] = "Sultan",[561] = "Stratum",[562] = "Elegy",[563] = "Raindance",[564] = "RC Tiger",[565] = "Flash",[566] = "Tahoma",[567] = "Savanna",[568] = "Bandito",[569] = "Train",[570] = "Train",[571] = "Kart",[572] = "Mower",[573] = "Dune",[574] = "Sweeper",[575] = "Broadway",[576] = "Tornado",[577] = "AT400",[578] = "DFT-30",[579] = "Huntley",[580] = "Stafford",[581] = "BF-400",[582] = "Newsvan",[583] = "Tug",[584] = "Petrol Trailer",[585] = "Emperor",[586] = "Wayfarer",[587] = "Euros",[588] = "Hotdog",[589] = "Club",[590] = "Train",[591] = "Article Trailer 3",[592] = "Andromada",[593] = "Dodo",[594] = "RC Cam",[595] = "Launch",[596] = "Police Car LS",[597] = "Police Car SF",[598] = "Police Car LV",[599] = "Police Ranger",[600] = "Picador",[601] = "S.W.A.T.",[602] = "Alpha",[603] = "Phoenix",[604] = "Glendale",[605] = "Sadler",[606] = "Baggage Trailer",[607] = "Baggage Trailer",[608] = "Tug Stairs Trailer",[609] = "Boxville",[610] = "Farm Trailer",[611] = "Utility Trailer"
    }
    return carNames[modelId] or "Desconhecido"
end
function getSkinNamebyModel(p621)
    return ({[0] = "Carl CJ",[1] = "The Truth",[2] = "Maccer",[3] = "Andre",[4] = "Barry",[5] = "Barry",[6] = "Emmet",[7] = "Taxi Driver",[8] = "Janitor",[9] = "Normal Ped",[10] = "Old Woman",[11] = "Casino croupier",[12] = "Casino croupier",[13] = "Street Girl",[14] = "Normal Ped",[15] = "Mr.Whittaker",[16] = "Airport Ground Worker",[17] = "Businessman",[18] = "Beach Visitor",[19] = "DJ",[20] = "Rich Guy",[21] = "Normal Ped",[22] = "Normal Ped",[23] = "BMXer",[24] = "Madd Dogg BodyGuard",[25] = "Madd Dogg BodyGuard",[26] = "Backpacker",[27] = "Construction Worker",[28] = "Drug Dealer",[29] = "Drug Dealer",[30] = "Drug Dealer",[31] = "Farm-Town",[32] = "Farm-Town",[33] = "Farm-Town",[34] = "Farm-Town",[35] = "Gardener",[36] = "Golfer",[37] = "Golfer",[38] = "Normal Ped",[39] = "Normal Ped",[40] = "Normal Ped",[41] = "Normal Ped",[42] = "Jethro",[43] = "Normal Ped",[44] = "Normal Ped",[45] = "Beach Visitor",[46] = "Normal Ped",[47] = "Normal Ped",[48] = "Normal Ped",[49] = "Snakehead",[50] = "Mechanic",[51] = "Mountain Biker",[52] = "Mountain Biker",[53] = "Unknown",[54] = "Normal Ped",[55] = "Normal Ped",[56] = "Normal Ped",[57] = "Oriental Ped",[58] = "Oriental Ped",[59] = "Normal Ped",[60] = "Normal Ped",[61] = "Pilot",[62] = "Colonel Fuhrberger",[63] = "Prostitute",[64] = "Prostitute",[65] = "Kendl Johnson",[66] = "Pool Player",[67] = "Pool Player",[68] = "Priest",[69] = "Normal Ped",[70] = "Scientist",[71] = "Security Guard",[72] = "Hippy",[73] = "Hippy",[74] = "CJ",[75] = "Prostitute",[76] = "Normal Ped",[77] = "Homeless",[78] = "Homeless",[78] = "Homeless",[79] = "Homeless",[80] = "Boxer",[81] = "Boxer",[82] = "Black Elvis",[83] = "White Elvis",[84] = "Blue Elvis",[85] = "Prostitute",[86] = "Ryder with robbery mask",[87] = "Stripper",[88] = "Normal Ped",[89] = "Normal Ped",[90] = "Jogger",[91] = "Rich Woman",[92] = "Normal Ped",[93] = "Normal Ped",[94] = "Normal Ped",[95] = "Normal Ped",[96] = "Jogger",[97] = "Lifeguard",[98] = "Normal Ped",[99] = "Rollerskater",[100] = "Biker",[101] = "Normal Ped",[102] = "Ballas",[103] = "Ballas",[104] = "Ballas",[105] = "Grove Street Fam.",[106] = "Grove Street Fam.",[107] = "Grove Street Fam.",[108] = "Los Santos Vagos",[109] = "Los Santos Vagos",[110] = "Los Santos Vagos",[111] = "The Russian Mafia",[112] = "The Russian Mafia",[113] = "The Russian Mafia Boss",[114] = "Varrios Los Aztecas",[115] = "Varrios Los Aztecas",[116] = "Varrios Los Aztecas",[117] = "Triad",[118] = "Triad",[119] = "Johhny Sindacco",[120] = "Triad Boss",[121] = "Da Nang Boy",[122] = "Da Nang Boy",[123] = "Da Nang Boy",[124] = "The Mafia",[125] = "The Mafia",[126] = "The Mafia",[127] = "The Mafia",[128] = "Farm Inhabitant",[129] = "Farm Inhabitant",[130] = "Farm Inhabitant",[131] = "Farm Inhabitant",[132] = "Farm Inhabitant",[133] = "Farm Inhabitant",[134] = "Homeless",[135] = "Homeless",[136] = "Normal Ped",[137] = "Homeless",[138] = "Beach Visitor",[139] = "Beach Visitor",[140] = "Beach Visitor",[141] = "Businesswoman",[142] = "Taxi Driver",[143] = "Crack Maker",[144] = "Crack Maker",[145] = "Crack Maker",[146] = "Crack Maker",[147] = "Businessman",[148] = "Businesswoman",[149] = "Big Smoke Armored",[150] = "Businesswoman",[151] = "Normal Ped",[152] = "Prostitute",[153] = "Construction Worker",[154] = "Beach Visitor",[155] = "Well Stacked Pizza Worker",[156] = "Barber",[157] = "Hillbilly",[158] = "Farmer",[158] = "Farmer",[159] = "Hillbilly",[160] = "Hillbilly",[161] = "Farmer",[162] = "Hillbilly",[163] = "Black Bouncer",[164] = "White Bouncer",[165] = "White MIB agent",[166] = "Black MIB agent",[167] = "Cluckin",[168] = "Hotdog",[169] = "Normal Ped",[170] = "Normal Ped",[171] = "Blackjack Dealer",[172] = "Casino croupier",[173] = "San Fierro Rifa",[174] = "San Fierro Rifa",[175] = "San Fierro Rifa",[176] = "Barber",[177] = "Barber",[178] = "Whore",[179] = "Ammunation Salesman",[180] = "Tattoo Artist",[181] = "Punk",[182] = "Cab Driver",[183] = "Normal Ped",[184] = "Normal Ped",[185] = "Normal Ped",[186] = "Normal Ped",[187] = "Buisnessman",[188] = "Normal Ped",[189] = "Normal Ped",[190] = "Barbara Schternvart",[191] = "Helena Wankstein",[192] = "Michelle Cannes",[193] = "Katie Zhan",[194] = "Millie Perkins",[195] = "Denise Robinson",[196] = "Farm-Town inhabitant",[197] = "Hillbilly",[198] = "Farm-Town inhabitant",[199] = "Farm-Town inhabitant",[200] = "Hillbilly",[201] = "Farmer",[202] = "Farmer",[203] = "Karate Teacher",[204] = "Karate Teacher",[205] = "Burger Shot Cashier",[206] = "Cab Driver",[207] = "Prostitute",[208] = "Su Xi Mu",[209] = "Oriental Noodle stand vendor",[210] = "Oriental Noodle stand vendor",[211] = "Clothes shop staff",[212] = "Homeless",[213] = "Weird old man",[214] = "Waitress",[215] = "Normal Ped",[216] = "Normal Ped",[217] = "Clothes shop staff",[218] = "Normal Ped",[219] = "Rich Woman",[220] = "Cab Driver",[221] = "Normal Ped",[222] = "Normal Ped",[223] = "Normal Ped",[224] = "Normal Ped",[225] = "Normal Ped",[226] = "Normal Ped",[227] = "Oriental Buisnessman",[228] = "Oriental Ped",[229] = "Oriental Ped",[230] = "Homeless",[231] = "Normal Ped",[232] = "Normal Ped",[233] = "Normal Ped",[234] = "Cab Driver",[235] = "Normal Ped",[236] = "Normal Ped",[237] = "Prostitute",[238] = "Prostitute",[239] = "Homeless",[240] = "The D.A",[241] = "Afro-American",[242] = "Mexican",[243] = "Prostitute",[244] = "Stripper",[245] = "Prostitute",[246] = "Stripper",[247] = "Biker",[248] = "Biker",[249] = "Pimp",[250] = "Normal Ped",[251] = "Lifeguard",[252] = "Naked Valet",[253] = "Bus Driver",[254] = "Biker Drug Dealer",[255] = "Chauffeur",[256] = "Stripper",[257] = "Stripper",[258] = "Heckler",[259] = "Heckler",[260] = "Construction Worker",[261] = "Cab driver",[262] = "Cab driver",[263] = "Normal Ped",[264] = "Clown",[265] = "Officer Frank Tenpenny",[266] = "Officer Eddie Pulaski",[267] = "Officer Jimmy Hernandez",[268] = "Dwaine",[269] = "Melvin \194\171Big Smoke\194\187 Harris",[270] = "Sean \194\171Sweet\194\187 Johnson",[271] = "Lance \194\171Ryder\194\187 Wilson",[272] = "Marco Forelli",[273] = "T-Bone Mendez",[274] = "Paramedic",[275] = "Paramedic",[276] = "Paramedic",[277] = "Firefighter",[278] = "Firefighter",[279] = "Firefighter",[280] = "Los Santos Police Officer",[281] = "San Fierro Police Officer",[282] = "Las Venturas Police Officer",[283] = "County Sheriff",[284] = "LSPD Motorbike Cop",[285] = "S.W.A.T Special Forces",[286] = "Federal Agent",[287] = "San Andreas",[288] = "Desert Sheriff",[289] = "Zero",[290] = "Ken Rosenberg",[291] = "Kent Paul",[292] = "Cesar Vialpando",[293] = "Jeffery",[294] = "Wu Zi Mu",[295] = "Michael Toreno",[296] = "Jizzy B",[297] = "Madd Dogg",[298] = "Catalina",[299] = "Claude Speed",[300] = "Los Santos Police Officer",[301] = "San Fierro Police Officer",[302] = "Las Venturas Police Officer",[303] = "Los Santos Police Officer",[304] = "Los Santos Police Officer",[305] = "Las Venturas Police Officer",[306] = "Los Santos Police Officer",[307] = "San Fierro Police Officer",[308] = "San Fierro Paramedic",[309] = "Las Venturas Police Officer",[310] = "Country Sheriff",[311] = "Desert Sheriff"})[p621]
end
function getSprintLocalPlayer()
    return vu9.getfloat(12045748) / 31.47000244
end
function getAmmoInClip()
    return vu9.getuint32(getCharPointer(PLAYER_PED) + 1440 + getWeapontypeSlot(getCurrentCharWeapon(PLAYER_PED)) * 28 + 8)
end
function show_stats(p622)
    local v623, v624 = sampGetCurrentServerAddress()
    local _, v625 = sampGetPlayerIdByCharHandle(PLAYER_PED)
    local v626 = sampIsPlayerPaused(v625)
    local v627 = sampIsPlayerNpc(v625)
    playersrwstream = sampGetPlayerCount(true)
    playersrwstream = playersrwstream - 1
    if isCharOnFoot(PLAYER_PED) then
        playerstatus = "OnFoot"
    else
        playerstatus = "InCar"
    end
    if GG_MEMORY.v then
        FULLMEM = script.pMemory.v
    end
    if not GG_MEMORY.v then
        FULLMEM = 512
    end
    if v626 then
        afk = "Yes"
    else
        afk = "No"
    end
    if v627 then
        npc = "Yes"
    else
        npc = "No"
    end
    if p622 then
        vu200.Text("Server IP: " .. v623 .. "")
        vu200.Text("Server PORT: " .. v624 .. "")
        vu200.Text("Players in stream: " .. playersrwstream .. "")
        vu200.Text("Player Status: " .. playerstatus .. "")
        vu200.Text(string.format("FPS: %.1f", vu200.GetIO().Framerate))
        vu200.Text(string.format("Memory: %.1f / " .. FULLMEM, get_memory()))
    else
        vu200.SetCursorPosY(2)
        vu200.ButtonHovered(" Player", vu200.ImVec2(vu200.GetWindowSize().x - 8, 23))
        vu200.Text("Name: " .. sampGetPlayerNickname(v625) .. "")
        vu200.Text(string.format("Player ID: %d", v625))
        vu200.Text(string.format("Skin: " .. getSkinNamebyModel(getCharModel(PLAYER_PED)) .. " (" .. getCharModel(PLAYER_PED) .. ")"))
        vu200.Text("Ping: " .. sampGetPlayerPing(v625) .. "")
        vu200.Text("Score: " .. sampGetPlayerScore(v625) .. "")
        vu200.Text("Color: " .. string.gsub(("%X"):format(sampGetPlayerColor(v625)), "..(......)", "%1") .. "")
        vu200.Text("Health: " .. sampGetPlayerHealth(v625) .. "")
        vu200.Text("Armour: " .. sampGetPlayerArmor(v625) .. "")
        vu200.Text("AFK Status: " .. afk .. "")
        vu200.ButtonHovered(" Client stats")
        vu200.Text("Server IP: " .. v623 .. "")
        vu200.Text("Server PORT: " .. v624 .. "")
        vu200.Text("Players in stream: " .. playersrwstream .. "")
        vu200.Text("Player Status: " .. playerstatus .. "")
        vu200.Text(string.format("FPS: %.1f", vu200.GetIO().Framerate))
        vu200.Text(string.format("Memory: %.1f / " .. FULLMEM, get_memory()))
    end
end
function Spam()
    lua_thread.create(function()
        while true do
            if not GG_bspam.v and GG_spam.v then
                wait(script.pspam.v)
                sampSendChat(tostring(script.textspam.v))
            end
            if GG_spam.v and GG_bspam.v then
                wait(script.pspam.v)
                sampSendChat("U08aVs8BuxRi2cZDTUNyuinQcNhBkS0oDx4uViwQb1tAKsb1OBceMiYPlspY")
                wait(script.pspam.v)
                sampSendChat("q39lLOaSUg9SXzYh86Sd9Ygwt5rELLKeK8zxFjzqCaWTgdj4skvjPLPreXDd")
                wait(script.pspam.v)
                sampSendChat("mbktDnEKJ2iRA5llTMmmfdCzhSkeSAOpxAFsf3ypK3HvXjk1hkf7mzDZ5vls")
                wait(script.pspam.v)
                sampSendChat("r1zag9bW9K5u27EfFxoaj0t6jNnkWO1J6S0Dmq61ExGYACisrd3Cow5XiL4C")
                wait(script.pspam.v)
                sampSendChat("yEGUdkBUSddIEa4ENRzTCSPfc5RWgGzCKJil767iQ5i1epPvodJBlYdKrzDM")
                wait(script.pspam.v)
                sampSendChat("iusTvJEEtYmkpsrDi8RCTgbSExN1exjg9RnpXOkEVaOtjLi6Nti5S8J311VZ")
                wait(script.pspam.v)
                sampSendChat("4NRq0RD4xyGOk1YWFTS9BK55DBzSlbIr7oISVrQyMXM53aiXoqvf3dkJefES")
                wait(script.pspam.v)
                sampSendChat("lJJGIQPxYV0ruHfUav4HQjR9wJhoB5l5Yk0BY3uzKesaizQ1jZjg0XSQcInh")
                wait(script.pspam.v)
                sampSendChat("71K8oPZ1jd3zcPqVLZzK3O5gNn0X0Oh5HEJCza5DEo7eyGQzJ7ivLELANAgJ")
                wait(script.pspam.v)
                sampSendChat("lLv5s8cZjYSjIJ2vf95O4r4xajbdHy9sCDHM8mGrKyOyBVE36qWA39dwvVh0")
                wait(script.pspam.v)
                sampSendChat("ogg3N0R3forxqpxS6wG1v3Lg9zzcG0OK8sbz26NM651xV20ACnGa1LQPfVN1")
                wait(script.pspam.v)
                sampSendChat("BciXsIK3AlNSUXXmFRHc5MQIP90HuVZtV40BcoKQMCdYqlDZihmKnZ1urNdE")
                wait(script.pspam.v)
                sampSendChat("UQuuSCvigsVY3QfNeJb4WI3OzXSNRmO7CPHcuBD7zX3rDynpp5D0KVezr3od")
                wait(script.pspam.v)
                sampSendChat("SbcV7iSl9stgAMQ68oqRnhiwbfrhmzysdoRDsNR2EetGMloVdEApOeT6YPkQ")
                wait(script.pspam.v)
                sampSendChat("GVWGck0HsnegevGSaw9fJ1L5HTbQQkfXRCv6MmwtEJcbN3Pgkt6oiq8UITv6")
                wait(script.pspam.v)
                sampSendChat("T8vqchJZtmBQO9UdQXzXbvJbQNa1YiJh2aXI1WMnTkOxFlqdzRSMnhxdHO1q")
                wait(script.pspam.v)
                sampSendChat("f86GdiMajTFNRj2m40HrsvzfshDUBE0NZyhGugv5HBdLGNIOzYRz5B2goDIB")
                wait(script.pspam.v)
                sampSendChat("CothcJyf9ldLWeHicOBy4PWjCWtstvPB3BH7YaqsIJagD9tvG5uQkL7CTJzK")
                wait(script.pspam.v)
                sampSendChat("rjHQ4t4cVTDDPC9Z4KCs8oUroXTSo0dvKxBHFaNP0Y30CRSD8dTQGXj42yk4")
                wait(script.pspam.v)
                sampSendChat("jfpfnFr4i27sRFnX1bxzoLxOqlc3zQAVusNKeW66F3Ud7EPTNMHzUaz1k7zX")
                wait(script.pspam.v)
                sampSendChat("B3yCgoKqA3h6EWM1l5vUMOvWNIpXwHwO0JOXxlWrYxxGFvW1vAnCHZ34bio6")
            end
            wait(0)
        end
    end)
end
function getClosestPlayerId()
    mydist = 30
    local v628, v629, v630 = getCharCoordinates(PLAYER_PED)
    local v631 = - 1
    for v632 = 0, 999 do
        local v633, v634 = sampGetCharHandleBySampPlayerId(v632)
        if v633 then
            if getCharHealth(v634) > 0 then
                if not sampIsPlayerPaused(v634) then
                    local v635, v636, v637 = getCharCoordinates(v634)
                    local v638 = getDistanceBetweenCoords3d(v628, v629, v630, v635, v636, v637)
                    if v638 <= mydist then
                        mydist = v638
                        v631 = v632
                    end
                end
            end
        end
    end
    return v631
end
function show_anim(p639, p640)
    if vu200.MenuItem(p639, "", false, true) then
        sampSetSpecialAction(0)
        clearCharTasksImmediately(PLAYER_PED)
        sampSetSpecialAction(p640)
    end
end
function getMusicList()
    local v641, v642 = findFirstFile("moonloader/" .. project.pName .. "/music/*.mp3")
    local v643 = {}
    while v642 do
        if v641 then
            if v642 then
                v643[# v643 + 1] = v642
                v642 = findNextFile(v641)
            else
                findClose(v641)
            end
        end
    end
    return v643
end
function vu200.ButtonHovered(p647)
    vu200.SetCursorPosX(0)
    vu200.PushStyleColor(vu200.Col.Border, vu200.ImVec4(0, 0, 0, 0))
    HoveredClr()
    vu200.Button(p647, vu200.ImVec2(vu200.GetWindowSize().x, 23))
    vu200.PopStyleColor(5)
end
function vu200.ToggleButtonAlpha(p648, p649)
    local v650 = false
    if LastActiveTime == nil then
        LastActiveTime = {}
    end
    if LastActive == nil then
        LastActive = {}
    end
    local function v652(p651)
        return p651 < 0 and 0 or (p651 > 1 and (1 or p651) or p651)
    end
    local v653 = vu200.GetCursorScreenPos()
    local v654 = vu200.GetWindowDrawList()
    local v655 = vu200.GetTextLineHeightWithSpacing()
    local v656 = v655 * 1.55
    local v657 = v655 * 0.5
    local v658 = 0.15
    if vu200.InvisibleButton(p648, vu200.ImVec2(v656, v655)) then
        p649.v = not p649.v
        LastActiveTime[tostring(p648)] = vu194.clock()
        LastActive[tostring(p648)] = true
        v650 = true
    end
    local v659 = p649.v and 1 or 0
    if LastActive[tostring(p648)] then
        local v660 = vu194.clock() - LastActiveTime[tostring(p648)]
        if v660 <= v658 then
            local v661 = v652(v660 / v658)
            v659 = p649.v and v661 and v661 or 1 - v661
        else
            LastActive[tostring(p648)] = false
        end
    end
    local v662
    if p649.v then
        v662 = vu200.GetColorU32(vu200.GetStyle().Colors[vu200.Col.FrameBgHovered])
    else
        v662 = vu200.ImColor(100, 100, 100, 180):GetU32()
    end
    v654:AddRectFilled(vu200.ImVec2(v653.x, v653.y + v655 / 6), vu200.ImVec2(v653.x + v656 - 1, v653.y + (v655 - v655 / 6)), v662, 5)
    v654:AddCircleFilled(vu200.ImVec2(v653.x + v657 + v659 * (v656 - v657 * 2), v653.y + v657), v657 - 0.75, vu200.GetColorU32(p649.v and vu200.GetStyle().Colors[vu200.Col.ButtonActive] or vu200.ImColor(150, 150, 150, 255):GetVec4()))
    return v650
end
function vu200.ToggleButton(p663, p664, p665, p666)
    vu200.PushFont(ToggleButton_Font)
    vu200.Text(p664)
    vu200.PopFont()
    vu200.SameLine(p665)
    vu200.PushStyleColor(vu200.Col.ButtonActive, vu200.ImVec4(0.0, 0.47, 0.84, 1.0))
    vu200.PushStyleColor(vu200.Col.FrameBgHovered, vu200.ImVec4(0.0, 0.35, 0.65, 1.0))
    vu200.ToggleButtonAlpha(p663, p666)
    vu200.PopStyleColor(2)
end

-- CheckboxRight: draw label on the left and the checkbox on the right (like ToggleButton)
function vu200.CheckboxRight(p_id, p_label, p_pos, p_var)
    -- Draw the visible label using ToggleButton font to keep visual consistency
    vu200.PushFont(ToggleButton_Font)
    vu200.Text(p_label)
    vu200.PopFont()
    -- Move to the specified X position (same behavior as ToggleButton)
    vu200.SameLine(p_pos)
    -- Use an internal id so the visible label isn't duplicated
    vu200.Checkbox("##" .. p_id .. "cb", p_var)
end

function vu200.Spinner(_, p667, p668, p669)
    local v670 = vu200.GetStyle()
    local v671 = vu200.GetCursorScreenPos()
    local v672 = vu200.ImVec2(p667 * 2, (p667 + v670.FramePadding.y) * 2) 
    vu200.Dummy(vu200.ImVec2(v672.x + v670.ItemSpacing.x, v672.y))
    local v673 = vu200.GetWindowDrawList()
    v673:PathClear()
    local v674 = 30
    local v675 = 6.28 * math.abs(math.sin(vu200.GetTime() * 1.8) * (v674 - 5)) / v674
    local v676 = 6.28 * (v674 - 3) / v674
    local v677 = vu200.ImVec2(v671.x + p667, v671.y + p667 + v670.FramePadding.y)
    for v678 = 0, v674 do
        local v679 = v675 + v678 / v674 * (v676 - v675)
        v673:PathLineTo(vu200.ImVec2(v677.x + math.cos(v679 + vu200.GetTime() * 8) * p667, v677.y + math.sin(v679 + vu200.GetTime() * 8) * p667))
    end
    v673:PathStroke(p669, false, p668)
    return true
end
function vu200.BufferingBar(_, p680, p681, p682, p683)
    local v684 = vu200.GetStyle()
    local v685 = vu200.GetWindowDrawList()
    p681.x = p681.x - v684.FramePadding.x * 2
    local v686 = vu200.GetCursorScreenPos()
    vu200.Dummy(vu200.ImVec2(p681.x, p681.y))
    local v687 = p681.x * 0.85
    local v688 = p681.x
    local v689 = v688 - v687
    v685:AddRectFilled(v686, vu200.ImVec2(v686.x + v687, v686.y + p681.y), p682)
    v685:AddRectFilled(v686, vu200.ImVec2(v686.x + v687 * p680, v686.y + p681.y), p683)
    local v690 = vu200.GetTime()
    local v691 = p681.y / 2
    local v692 = 1.5
    local v693 = v692 * 0
    local v694 = v692 * 0.333
    local v695 = v692 * 0.666
    local v696 = (v689 + v691) * (v690 + v693 - v692 * math.floor((v690 + v693) / v692)) / v692
    local v697 = (v689 + v691) * (v690 + v694 - v692 * math.floor((v690 + v694) / v692)) / v692
    local v698 = (v689 + v691) * (v690 + v695 - v692 * math.floor((v690 + v695) / v692)) / v692
    v685:AddCircleFilled(vu200.ImVec2(v686.x + v688 - v696, v686.y + v691), v691, p682)
    v685:AddCircleFilled(vu200.ImVec2(v686.x + v688 - v697, v686.y + v691), v691, p682)
    v685:AddCircleFilled(vu200.ImVec2(v686.x + v688 - v698, v686.y + v691), v691, p682)
    return true
end
function vu200.VerticalSeparator()
    local v699 = vu200.GetCursorScreenPos()
    vu200.GetWindowDrawList():AddLine(vu200.ImVec2(v699.x, v699.y), vu200.ImVec2(v699.x, v699.y + vu200.GetContentRegionMax().y - 8), vu200.GetColorU32(vu200.GetStyle().Colors[vu200.Col.Separator]))
end
function vu200.CustomSeparator()
    local v700 = vu200.GetCursorScreenPos()
    vu200.GetWindowDrawList():AddLine(vu200.ImVec2(v700.x, v700.y), vu200.ImVec2(v700.x + (vu200.GetWindowSize().x - vu200.GetStyle().ItemSpacing.y * 2), v700.y), vu200.GetColorU32(vu200.GetStyle().Colors[vu200.Col.Separator]))
    vu200.GetWindowDrawList():AddLine(vu200.ImVec2(v700.x, v700.y + 1), vu200.ImVec2(v700.x + (vu200.GetWindowSize().x - vu200.GetStyle().ItemSpacing.y * 2), v700.y + 1), vu200.GetColorU32(vu200.GetStyle().Colors[vu200.Col.Separator]))
    vu200.PushStyleVar(vu200.StyleVar.ItemSpacing, vu200.ImVec2(4, 5))
    vu200.Spacing()
    vu200.PopStyleVar()
end
function vu200.LeftButton(p701, p702, p703)
    vu200.PushStyleVar(vu200.StyleVar.ButtonTextAlign, vu200.ImVec2(0.05, 0.5))
    vu200.PushStyleColor(vu200.Col.Button, vu200.ImVec4(0, 0, 0, 0))
    vu200.PushStyleColor(vu200.Col.ButtonHovered, vu200.ImVec4(0, 0, 0, 0))
    vu200.PushStyleColor(vu200.Col.ButtonActive, vu200.ImVec4(0.12, 0.12, 0.12, 1))
    if vu200.AnimButton(p701, p702) then
        script.page = p703
    end
    vu200.PopStyleColor(3)
    vu200.PopStyleVar()
end
function DisabledButton(p704, p705)
    vu200.PushStyleColor(vu200.Col.Button, vu200.ImVec4(0.41, 0.19, 0.63, 0.44))
    vu200.PushStyleColor(vu200.Col.ButtonHovered, vu200.ImVec4(0.41, 0.19, 0.63, 0.44))
    vu200.PushStyleColor(vu200.Col.ButtonActive, vu200.ImVec4(0.41, 0.19, 0.63, 0.44))
    vu200.PushStyleColor(vu200.Col.Text, vu200.ImVec4(0.5, 0.5, 0.5, 1))
    vu200.Button(p704, p705)
    vu200.PopStyleColor(4)
end
function vu200.LeftButtonHovered(p706, p707)
    vu200.PushStyleVar(vu200.StyleVar.ButtonTextAlign, vu200.ImVec2(0.05, 0.5))
    vu200.PushStyleColor(vu200.Col.Button, vu200.ImVec4(0, 0.47, 0.84, 0.3)) 
    vu200.PushStyleColor(vu200.Col.ButtonHovered, vu200.ImVec4(0, 0.47, 0.84, 0.3))
    vu200.PushStyleColor(vu200.Col.ButtonActive, vu200.ImVec4(0, 0.47, 0.84, 0.3))
    vu200.PushStyleColor(vu200.Col.Text, vu200.ImVec4(1, 1, 1, 1))
    vu200.Button(p706, p707)
    vu200.PopStyleColor(4)
    vu200.PopStyleVar()
end
function HoveredClr()
    vu200.PushStyleColor(vu200.Col.Button, vu200.ImVec4(0.98, 0.06, 0.06, 1))
    vu200.PushStyleColor(vu200.Col.ButtonHovered, vu200.ImVec4(0.98, 0.26, 0.26, 1))
    vu200.PushStyleColor(vu200.Col.ButtonActive, vu200.ImVec4(0.98, 0.26, 0.26, 0.4))
    vu200.PushStyleColor(vu200.Col.Text, vu200.ImVec4(1, 1, 1, 1))
end
function WindowBg()
    vu200.PushStyleColor(vu200.Col.Border, vu200.ImVec4(0, 0, 0, 0))
    vu200.PushStyleColor(vu200.Col.WindowBg, vu200.ImVec4(0, 0, 0, 0.5))
end
function ApplySyle()
    vu200.SwitchContext()
    local v708 = vu200.GetStyle()
    local v709 = v708.Colors
    local v710 = vu200.Col
    local v711 = vu200.ImVec4
    local _ = vu200.ImVec2
    v708.WindowRounding = 3
    v708.WindowTitleAlign = vu200.ImVec2(0.5, 0.5)
    v708.ChildWindowRounding = 3
    v708.FrameRounding = 3
    v708.ItemSpacing = vu200.ImVec2(5, 4)
    v708.ScrollbarSize = 13
    v708.ScrollbarRounding = 1
    v708.GrabMinSize = 8
    v708.GrabRounding = 3
    v708.WindowPadding = vu200.ImVec2(4, 4)
    v708.FramePadding = vu200.ImVec2(2.5, 3.5)
    v708.ButtonTextAlign = vu200.ImVec2(0.02, 0.4)
    v709[v710.Text] = v711(1, 1, 1, 1)
    v709[v710.TextDisabled] = v711(0.5, 0.5, 0.5, 1)
    v709[v710.WindowBg] = v711(0, 0, 0, 1)
    v709[v710.ChildWindowBg] = v711(0, 0, 0, 1)
    v709[v710.PopupBg] = v711(0.08, 0.08, 0.08, 0.94)
    v709[v710.ComboBg] = v709[v710.PopupBg]
    v709[v710.Border] = v711(0.43, 0.43, 0.5, 0.5)
    v709[v710.BorderShadow] = v711(0, 0, 0, 0)
    v709[v710.FrameBg] = v711(0.12, 0.12, 0.12, 0.94)
    v709[v710.FrameBgHovered] = v711(0.45, 0.45, 0.45, 0.85)
    v709[v710.FrameBgActive] = v711(0.63, 0.63, 0.63, 0.63)
    v709[v710.TitleBg] = v711(0.13, 0.13, 0.13, 0.99)
    v709[v710.TitleBgActive] = v711(0.13, 0.13, 0.13, 0.99)
    v709[v710.TitleBgCollapsed] = v711(0.05, 0.05, 0.05, 0.79)
    v709[v710.MenuBarBg] = v711(0.14, 0.14, 0.14, 1)
    v709[v710.ScrollbarBg] = v711(0.13, 0.13, 0.13, 0.99)
    v709[v710.ScrollbarGrab] = v711(0.31, 0.31, 0.31, 1)
    v709[v710.ScrollbarGrabHovered] = v711(0.41, 0.41, 0.41, 1)
    v709[v710.ScrollbarGrabActive] = v711(0.51, 0.51, 0.51, 1)
    v709[v710.CheckMark] = v711(1, 1, 1, 1)
    v709[v710.SliderGrab] = v711(0.28, 0.28, 0.28, 1)
    v709[v710.SliderGrabActive] = v711(0.35, 0.35, 0.35, 1)
    v709[v710.Button] = v711(0.12, 0.12, 0.12, 0.94)
    v709[v710.ButtonHovered] = v711(0.34, 0.34, 0.35, 0.89)
    v709[v710.ButtonActive] = v711(0.21, 0.21, 0.21, 0.81)
    v709[v710.Header] = v711(0.12, 0.12, 0.12, 0.94)
    v709[v710.HeaderHovered] = v711(0.34, 0.34, 0.35, 0.89)
    v709[v710.HeaderActive] = v711(0.12, 0.12, 0.12, 0.94)
    v709[v710.Separator] = v709[v710.Border]
    v709[v710.SeparatorHovered] = v711(0.26, 0.59, 0.98, 0.78)
    v709[v710.SeparatorActive] = v711(0.26, 0.59, 0.98, 1)
    v709[v710.ResizeGrip] = v711(0.26, 0.59, 0.98, 0.25)
    v709[v710.ResizeGripHovered] = v711(0.26, 0.59, 0.98, 0.67)
    v709[v710.ResizeGripActive] = v711(0.26, 0.59, 0.98, 0.95)
    v709[v710.CloseButton] = v711(0.41, 0.41, 0.41, 0.5)
    v709[v710.CloseButtonHovered] = v711(0.98, 0.39, 0.36, 1)
    v709[v710.CloseButtonActive] = v711(0.98, 0.39, 0.36, 1)
    v709[v710.PlotLines] = v711(0.61, 0.61, 0.61, 1)
    v709[v710.PlotLinesHovered] = v711(1, 0.43, 0.35, 1)
    v709[v710.PlotHistogram] = v711(0.9, 0.7, 0, 1)
    v709[v710.PlotHistogramHovered] = v711(1, 0.6, 0, 1)
    v709[v710.TextSelectedBg] = v711(0.26, 0.59, 0.98, 0.35)
    v709[v710.ModalWindowDarkening] = v711(0.8, 0.8, 0.8, 0.35)
end
function vu200.CustomRadioButton(p712, p713, p714, ...)
    if tonumber(p713.v) == tonumber(p714) then
        HoveredClr()
        local v715 = vu200.Button(p712, ...)
        vu200.PopStyleColor(4)
        return v715
    end
    if vu200.Button(p712, ...) then
        p713.v = tonumber(p714)
        return true
    end
end
function vu200.Hint(p716, p717)
    if vu200.IsItemHovered() then
        if go_hint == nil then
            go_hint = vu194.clock() + (p717 or 0)
        end
        local v718 = (vu194.clock() - go_hint) * 5
        if vu194.clock() >= go_hint then
            vu200.PushStyleVar(vu200.StyleVar.Alpha, v718 <= 1 and v718 and v718 or 1)
            vu200.BeginTooltip()
            vu200.PushTextWrapPos(450)
            vu200.TextUnformatted(p716)
            if not vu200.IsItemVisible() and vu200.GetStyle().Alpha == 1 then
                go_hint = nil
            end
            vu200.PopTextWrapPos()
            vu200.EndTooltip()
            vu200.PopStyleVar()
        end
    end
end
function vu200.HintTooltip(p719, p720)
    vu200.SameLine()
    vu200.TextColored(vu200.ImVec4(128, 128, 128, 0.3), vu8.ICON_FA_QUESTION_CIRCLE)
    if vu200.IsItemHovered() then
        if go_hint == nil then
            go_hint = vu194.clock() + (p720 or 0)
        end
        local v721 = (vu194.clock() - go_hint) * 5
        if vu194.clock() >= go_hint then
            vu200.PushStyleVar(vu200.StyleVar.Alpha, v721 <= 1 and v721 and v721 or 1)
            vu200.BeginTooltip()
            vu200.PushTextWrapPos(450)
            vu200.Text(p719)
            if not vu200.IsItemVisible() and vu200.GetStyle().Alpha == 1 then
                go_hint = nil
            end
            vu200.PopTextWrapPos()
            vu200.EndTooltip()
            vu200.PopStyleVar()
        end
    end
end
function vu200.HintTooltipQuestion(p722, p723)
    vu200.TextDisabled(vu8.ICON_FA_QUESTION_CIRCLE)
    if vu200.IsItemHovered() then
        if go_hint == nil then
            go_hint = vu194.clock() + (p723 or 0)
        end
        local v724 = (vu194.clock() - go_hint) * 5
        if vu194.clock() >= go_hint then
            vu200.PushStyleVar(vu200.StyleVar.Alpha, v724 <= 1 and v724 and v724 or 1)
            vu200.BeginTooltip()
            vu200.PushTextWrapPos(450)
            vu200.TextUnformatted(p722)
            if not vu200.IsItemVisible() and vu200.GetStyle().Alpha == 1 then
                go_hint = nil
            end
            vu200.PopTextWrapPos()
            vu200.EndTooltip()
            vu200.PopStyleVar()
        end
    end
end
function vu200.HintTooltipWarn(p725)
    vu200.PushStyleColor(vu200.Col.TextDisabled, vu200.ImVec4(0.82, 0.44, 0, 1))
    vu200.TextDisabled(vu8.ICON_FA_EXCLAMATION_TRIANGLE)
    vu200.PopStyleColor(1)
    if vu200.IsItemHovered() then
        if go_hint == nil then
            go_hint = vu194.clock() + (delay and delay or 0)
        end
        local v726 = (vu194.clock() - go_hint) * 5
        if vu194.clock() >= go_hint then
            vu200.PushStyleVar(vu200.StyleVar.Alpha, v726 <= 1 and v726 and v726 or 1)
            vu200.BeginTooltip()
            vu200.PushTextWrapPos(450)
            vu200.TextUnformatted(p725)
            if not vu200.IsItemVisible() and vu200.GetStyle().Alpha == 1 then
                go_hint = nil
            end
            vu200.PopTextWrapPos()
            vu200.EndTooltip()
            vu200.PopStyleVar()
        end
    end
end
function vu200.HintTooltipError(p727)
    vu200.PushStyleColor(vu200.Col.TextDisabled, vu200.ImVec4(0.82, 0, 0, 1))
    vu200.TextDisabled(vu8.ICON_FA_EXCLAMATION_CIRCLE)
    vu200.PopStyleColor(1)
    if vu200.IsItemHovered() then
        if go_hint == nil then
            go_hint = vu194.clock() + (delay and delay or 0)
        end
        local v728 = (vu194.clock() - go_hint) * 5
        if vu194.clock() >= go_hint then
            vu200.PushStyleVar(vu200.StyleVar.Alpha, v728 <= 1 and v728 and v728 or 1)
            vu200.BeginTooltip()
            vu200.PushTextWrapPos(450)
            vu200.TextUnformatted(p727)
            if not vu200.IsItemVisible() and vu200.GetStyle().Alpha == 1 then
                go_hint = nil
            end
            vu200.PopTextWrapPos()
            vu200.EndTooltip()
            vu200.PopStyleVar()
        end
    end
end
function vu200.Link(p729, p730)
    local v731 = vu200.CalcTextSize(p729)
    local v732 = vu200.GetCursorPos()
    vu200.InvisibleButton(p729, vu200.ImVec2(v731.x, v731.y))
    vu200.SameLine()
    vu200.SetCursorPos(v732)
    if vu200.IsItemHovered() then
        if p730 then
            vu200.BeginTooltip()
            vu200.PushTextWrapPos(640)
            vu200.TextUnformatted(p730)
            vu200.PopTextWrapPos()
            vu200.EndTooltip()
        end
        vu200.PushStyleColor(vu200.Col.Text, vu200.ImVec4(0, 0.6, 1, 1))
        vu200.Text(p729)
        vu200.PopStyleColor()
        if vu200.IsMouseClicked(0) then
            return true
        end
    else
        vu200.PushStyleColor(vu200.Col.Text, vu200.ImVec4(0, 0.45, 1, 1))
        vu200.Text(p729)
        vu200.PopStyleColor()
    end
end
function vu200.UrlLink(p733, p734)
    local v735 = vu200.CalcTextSize(p733)
    local v736 = vu200.GetCursorPos()
    vu200.InvisibleButton(p733, vu200.ImVec2(v735.x, v735.y))
    vu200.SameLine()
    vu200.SetCursorPos(v736)
    if vu200.IsItemHovered() then
        if p734 then
            vu200.BeginTooltip()
            vu200.PushTextWrapPos(640)
            vu200.TextUnformatted(p734)
            vu200.PopTextWrapPos()
            vu200.EndTooltip()
        end
        vu200.PushStyleColor(vu200.Col.Text, vu200.ImVec4(0, 0.6, 1, 1))
        vu200.Text(p733)
        vu200.PopStyleColor()
        if vu200.IsMouseClicked(0) then
            vu194.execute("explorer \"" .. p734 .. "\"")
        end
    else
        vu200.PushStyleColor(vu200.Col.Text, vu200.ImVec4(0, 0.45, 1, 1))
        vu200.Text(p733)
        vu200.PopStyleColor()
    end
end
function rainbow32(p737, p738, p739)
    local v740 = vu194.clock() + p739
    local v741 = math.floor(math.sin(v740 * p737) * 127 + 128)
    local v742 = math.floor(math.sin(v740 * p737 + 2) * 127 + 128)
    local v743 = math.floor(math.sin(v740 * p737 + 4) * 127 + 128)
    return v741 / 255, v742 / 255, v743 / 255, p738 / 255
end
function rainbow(p744, p745, p746)
    local v747 = vu194.clock() + p746
    return math.floor(math.sin(v747 * p744) * 127 + 128), math.floor(math.sin(v747 * p744 + 2) * 127 + 128), math.floor(math.sin(v747 * p744 + 4) * 127 + 128), p745
end
function rainbow_line(p748, p749)
    local v750 = vu200.GetCursorPos()
    local v751 = vu200.GetCursorScreenPos()
    for v752 = 0, p748 do
        local v753, v754, v755, v756 = rainbow(1, 255, v752 / - 50)
        a = v756
        b = v755
        g = v754
        r = v753
        vu200.GetWindowDrawList():AddRectFilled(vu200.ImVec2(v751.x + v752, v751.y), vu200.ImVec2(v751.x + v752 + 1, v751.y + p749), join_argb(a, r, g, b))
    end
    vu200.SetCursorPos(vu200.ImVec2(v750.x, v750.y + p749 + vu200.GetStyle().ItemSpacing.y))
end
function static_rainbow_line(p757, p758)
    local v759 = vu200.GetCursorPos()
    local v760 = vu200.GetCursorScreenPos()
    for v761 = 0, p757 do
        local v762, v763, v764, v765 = rainbow_v2(1, 255, v761 / - 50)
        a = v765
        b = v764
        g = v763
        r = v762
        vu200.GetWindowDrawList():AddRectFilled(vu200.ImVec2(v760.x + v761, v760.y), vu200.ImVec2(v760.x + v761 + 1, v760.y + p758), join_argb(a, r, g, b))
    end
    vu200.SetCursorPos(vu200.ImVec2(v759.x, v759.y + p758 + vu200.GetStyle().ItemSpacing.y))
end
function rainbow_v2(p766, p767, p768)
    return math.floor(math.sin(p768 * p766) * 127 + 128), math.floor(math.sin(p768 * p766 + 2) * 127 + 128), math.floor(math.sin(p768 * p766 + 4) * 127 + 128), p767
end
function join_argb(p769, p770, p771, p772)
    local v773 = bit.bor(p772, bit.lshift(p771, 8))
    local v774 = bit.bor(v773, bit.lshift(p770, 16))
    return bit.bor(v774, bit.lshift(p769, 24))
end
function explode_argb(p775)
    return bit.band(bit.rshift(p775, 24), 255), bit.band(bit.rshift(p775, 16), 255), bit.band(bit.rshift(p775, 8), 255), bit.band(p775, 255)
end
function bringVec4To(p776, p777, p778, p779)
    local v780 = vu194.clock() - p778
    if 0 > v780 or v780 > p779 then
        return p779 < v780 and p777 and p777 or p776, false
    end
    local v781 = v780 / (p779 / 100)
    return vu200.ImVec4(p776.x + v781 * (p777.x - p776.x) / 100, p776.y + v781 * (p777.y - p776.y) / 100, p776.z + v781 * (p777.z - p776.z) / 100, p776.w + v781 * (p777.w - p776.w) / 100), true
end
function vu200.HeaderButton(p782, p783)
    local v784 = vu200.GetWindowDrawList()
    local v785 = vu200.ColorConvertFloat4ToU32
    local v786 = false
    local v787 = string.gsub(p783, "##.*$", "")
    local v788 = {
        0.5,
        0.3
    }
    local v789 = {
        idle = vu200.GetStyle().Colors[vu200.Col.TextDisabled],
        hovr = vu200.GetStyle().Colors[vu200.Col.Text],
        slct = vu200.GetStyle().Colors[vu200.Col.ButtonActive]
    }
    if not AI_HEADERBUT then
        AI_HEADERBUT = {}
    end
    if not AI_HEADERBUT[p783] then
        AI_HEADERBUT[p783] = {
            color = p782 and v789.slct or v789.idle,
            clock = vu194.clock() + v788[1],
            h = {
                state = p782,
                alpha = p782 and 1 or 0,
                clock = vu194.clock() + v788[2]
            }
        }
    end
    local v790 = AI_HEADERBUT[p783]
    local function v797(p791, p792, p793, p794)
        local v795 = vu194.clock() - p793
        if v795 >= 0 then
            local v796 = {
                x = p792.x - p791.x,
                y = p792.y - p791.y,
                z = p792.z - p791.z,
                w = p792.w - p791.w
            }
            p791.x = p791.x + v796.x / p794 * v795
            p791.y = p791.y + v796.y / p794 * v795
            p791.z = p791.z + v796.z / p794 * v795
            p791.w = p791.w + v796.w / p794 * v795
        end
        return p791
    end
    local function v803(p798, p799, p800, p801)
        local v802 = vu194.clock() - p800
        if v802 >= 0 then
            p798 = p798 + (p799 - p798) / p801 * v802
        end
        return p798
    end
    local function v806(p804, p805)
        return vu200.ImVec4(p804.x, p804.y, p804.z, p805 or 1)
    end
    vu200.BeginGroup()
    vu200.GetCursorPos()
    local v807 = vu200.GetCursorScreenPos()
    vu200.TextColored(v790.color, v787)
    local v808 = vu200.GetItemRectSize()
    local v809 = vu200.IsItemHovered()
    local v810 = vu200.IsItemClicked()
    if v790.h.state ~= v809 and not p782 then
        v790.h.state = v809
        v790.h.clock = vu194.clock()
    end
    if v810 then
        v790.clock = vu194.clock()
        v786 = true
    end
    if vu194.clock() - v790.clock > v788[1] then
        v790.color = p782 and v789.slct or (v809 and v789.hovr or v789.idle)
    else
        v790.color = v797(vu200.ImVec4(v790.color), p782 and v789.slct or (v809 and v789.hovr or v789.idle), v790.clock, v788[1])
    end
    if v790.h.clock ~= nil then
        if vu194.clock() - v790.h.clock > v788[2] then
            v790.h.alpha = v790.h.state and 1 or 0
            if not v790.h.state then
                v790.h.clock = nil
            end
        else
            v790.h.alpha = v803(v790.h.alpha, v790.h.state and 1 or 0, v790.h.clock, v788[2])
        end
        local v811 = v808.x / 2
        local v812 = v807.y + v808.y + 3
        local v813 = v807.x + v811
        v784:AddLine(vu200.ImVec2(v813, v812), vu200.ImVec2(v813 + v811 * v790.h.alpha, v812), v785(v806(v790.color, v790.h.alpha)), 3)
        v784:AddLine(vu200.ImVec2(v813, v812), vu200.ImVec2(v813 - v811 * v790.h.alpha, v812), v785(v806(v790.color, v790.h.alpha)), 3)
    end
    vu200.EndGroup()
    return v786
end
function vu200.AnimButton(p814, p815, p816)
    local v817 = type(p816) ~= "table" and {
        1,
        0.3
    } or p816
    local v818 = {
        default = vu200.ImVec4(vu200.GetStyle().Colors[vu200.Col.Button]),
        hovered = vu200.ImVec4(vu200.GetStyle().Colors[vu200.Col.ButtonHovered]),
        active = vu200.ImVec4(vu200.GetStyle().Colors[vu200.Col.ButtonActive])
    }
    if UI_ANIMBUT == nil then
        UI_ANIMBUT = {}
    end
    if not UI_ANIMBUT[p814] then
        UI_ANIMBUT[p814] = {
            color = v818.default,
            clicked = {
                nil,
                nil
            },
            hovered = {
                cur = false,
                old = false,
                clock = nil
            }
        }
    end
    local v819 = UI_ANIMBUT[p814]
    local v820 = false
    if v819.clicked[1] and v819.clicked[2] then
        if vu194.clock() - v819.clicked[1] > v817[2] then
            if vu194.clock() - v819.clicked[2] <= v817[2] then
                v819.color = bringVec4To(v819.color, v819.hovered.cur and v818.hovered or v818.default, v819.clicked[2], v817[2])
                v820 = true
            end
        else
            v819.color = bringVec4To(v819.color, v818.active, v819.clicked[1], v817[2])
            v820 = true
        end
    end
    if not v820 and v819.hovered.clock ~= nil then
        if vu194.clock() - v819.hovered.clock > v817[1] then
            v819.color = v819.hovered.cur and v818.hovered or v818.default
        else
            v819.color = bringVec4To(v819.color, v819.hovered.cur and v818.hovered or v818.default, v819.hovered.clock, v817[1])
        end
    end
    vu200.PushStyleColor(vu200.Col.Button, vu200.ImVec4(v819.color))
    vu200.PushStyleColor(vu200.Col.ButtonHovered, vu200.ImVec4(v819.color))
    vu200.PushStyleColor(vu200.Col.ButtonActive, vu200.ImVec4(v819.color))
    local v821 = vu200.Button(p814, p815 or vu200.ImVec2(0, 0))
    vu200.PopStyleColor(3)
    if v821 then
        v819.clicked = {
            vu194.clock(),
            vu194.clock() + v817[2]
        }
    end
    v819.hovered.cur = vu200.IsItemHovered()
    if v819.hovered.old ~= v819.hovered.cur then
        v819.hovered.old = v819.hovered.cur
        v819.hovered.clock = vu194.clock()
    end
    return v821
end
function vu200.AnimatedButton(p822, p823, p824, pu825)
    local v826 = p823 or vu200.ImVec2(0, 0)
    local v827 = false
    local v828 = p822:gsub("##.+$", "")
    local v829 = vu200.CalcTextSize(v828)
    local v830 = p824 or 0.4
    if not AnimatedButtons then
        AnimatedButtons = {}
    end
    if not AnimatedButtons[p822] then
        local v831 = vu200.GetStyle().Colors[vu200.Col.ButtonHovered]
        AnimatedButtons[p822] = {
            circles = {},
            hovered = false,
            state = false,
            time = vu194.clock(),
            color = vu200.ImVec4(v831.x, v831.y, v831.z, 0.2)
        }
    end
    local v832 = AnimatedButtons[p822]
    local v833 = vu200.GetWindowDrawList()
    local v834 = vu200.GetCursorScreenPos()
    local vu835 = vu200.GetCursorPos()
    local v840 = (function(p836, p837, p838)
        local v839 = vu200.GetContentRegionMax()
        if p836.x ~= 0 then
            if p836.x < 0 then
                p836.x = math.max(4, v839.x - vu835.x + p836.x)
            end
        else
            p836.x = p837
        end
        if p836.y ~= 0 then
            if p836.y < 0 then
                p836.y = math.max(4, v839.y - vu835.y + p836.y)
            end
        else
            p836.y = p838
        end
        return p836
    end)(v826, v829.x + vu200.GetStyle().FramePadding.x * 2, v829.y + vu200.GetStyle().FramePadding.y * 2)
    local function v842(p841)
        return p841 < 0 and 0 or (p841 > 1 and (1 or p841) or p841)
    end
    local v843
    if # v832.circles <= 0 then
        v843 = vu835
    else
        local function v849(p844, p845, p846)
            local v847 = pu825 and vu200.GetStyle().FrameRounding or 0
            if v847 > 0 and pu825 then
                local v848 = vu200.GetWindowDrawList()
                v848:PathLineTo(p844)
                v848:PathArcTo(vu200.ImVec2(p844.x + v847, p844.y + v847), v847, - 3, - 1.5)
                v848:PathFillConvex(p846)
                v848:PathLineTo(vu200.ImVec2(p845.x, p844.y))
                v848:PathArcTo(vu200.ImVec2(p845.x - v847, p844.y + v847), v847, - 1.5, - 0.205)
                v848:PathFillConvex(p846)
                v848:PathLineTo(vu200.ImVec2(p845.x, p845.y))
                v848:PathArcTo(vu200.ImVec2(p845.x - v847, p845.y - v847), v847, 1.5, 0.205)
                v848:PathFillConvex(p846)
                v848:PathLineTo(vu200.ImVec2(p844.x, p845.y))
                v848:PathArcTo(vu200.ImVec2(p844.x + v847, p845.y - v847), v847, 3, 1.5)
                v848:PathFillConvex(p846)
            end
        end
        local v850, v851, v852 = ipairs(v832.circles)
        v843 = vu835
        while true do
            local v853
            v852, v853 = v850(v851, v852)
            if v852 == nil then
                break
            end
            local v854 = v842((vu194.clock() - v853.time) / v830)
            local v855 = vu200.GetStyle().Colors[vu200.Col.ButtonActive]
            local v856 = vu200.GetColorU32(vu200.ImVec4(v855.x, v855.y, v855.z, (v853.reverse and 255 - 255 * v854 or 255 * v854) / 255))
            local v857 = math.max(v840.x, v840.y) * (v853.reverse and (1.5 or v854) or v854)
            vu200.PushClipRect(v834, vu200.ImVec2(v834.x + v840.x, v834.y + v840.y), true)
            v833:AddCircleFilled(v853.clickpos, v857, v856, v857 / 2)
            v849(v834, vu200.ImVec2(v834.x + v840.x, v834.y + v840.y), vu200.GetColorU32(vu200.GetStyle().Colors[vu200.Col.WindowBg]))
            vu200.PopClipRect()
            if v854 == 1 then
                if v853.reverse then
                    table.remove(v832.circles, v852)
                else
                    v853.reverse = true
                    v853.time = vu194.clock()
                end
            end
        end
    end
    local v858 = v842((vu194.clock() - v832.time) / v830)
    v832.color.w = v832.color.w + (v832.hovered and 0.8 or - 0.8) * v858
    v832.color.w = v832.color.w < 0.2 and 0.2 or (v832.color.w > 1 and 1 or v832.color.w)
    color = vu200.GetStyle().Colors[vu200.Col.Button]
    color = vu200.GetColorU32(vu200.ImVec4(color.x, color.y, color.z, 0.2))
    v833:AddRectFilled(v834, vu200.ImVec2(v834.x + v840.x, v834.y + v840.y), color, pu825 and vu200.GetStyle().FrameRounding or 0)
    v833:AddRect(v834, vu200.ImVec2(v834.x + v840.x, v834.y + v840.y), vu200.GetColorU32(v832.color), pu825 and vu200.GetStyle().FrameRounding or 0)
    local v859 = vu200.GetStyle().ButtonTextAlign
    vu200.SetCursorPos(vu200.ImVec2(v843.x + (v840.x - v829.x) * v859.x, v843.y + (v840.y - v829.y) * v859.y))
    vu200.Text(v828)
    vu200.SetCursorPos(v843)
    if vu200.InvisibleButton(p822, v840) then
        table.insert(v832.circles, {
            animate = true,
            reverse = false,
            time = vu194.clock(),
            clickpos = vu200.ImVec2(getCursorPos())
        })
        v827 = true
    end
    v832.hovered = vu200.IsItemHovered()
    if v832.hovered ~= v832.state then
        v832.state = v832.hovered
        v832.time = vu194.clock()
    end
    return v827
end
function CleanMemory()
    callFunction(4249536, 1, 1, - 1)
end
function round(p860, p861)
    local v862 = 10 ^ (p861 or 0)
    return math.floor(p860 * v862 + 0.5) / v862
end
function get_memory()
    return round(vu9.read(9325748, 4, true) / 1048576, 1)
end
function fake_spawn()
    lua_thread.create(function()
        script.bypass = true
        enableDialog(false)
        emul_rpc("onTogglePlayerSpectating", {
            false
        })
        emul_rpc("onRequestSpawnResponse", {
            true
        })
        emul_rpc("onSetSpawnInfo", {
            0,
            0,
            0,
            {
                0,
                0,
                0
            },
            0,
            {
                0
            },
            {
                0
            }
        })
        wait(1000)
        sampSpawnPlayer()
        restoreCameraJumpcut()
        setCharCoordinates(playerPed, 1544.2493, - 1352.8827, 329.475)
        message("ByPass Spawn Started")
        printStringNow("~b~You are spawned", 7000)
        script.bypass = false
    end)
end
if GG_dirigirsemlicenca[0] and (GG_dirigirsemlicenca[1] and (isCharInAnyCar(1) and os.clock() - firstTimeSitInCar > 1)) then
    local vehicleHandle = storeCarCharIsInNoSave(1)
    setCarEngineOn(vehicleHandle, true)
            sampForceOnfootSync()
            local v242 = select(2, sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(1)))
            if v242 then
                sampSendEnterVehicle(v242)
            end
        end
lua_thread.create(function()
    while true do
        repeat
            wait(0)
        until GG_destrancar.v
        local v450, v451, v452 = ipairs(getAllVehicles())
        while true do
            local v453
            v452, v453 = v450(v451, v452)
            if v452 == nil then
                break
            end
            local v454, v455, v456 = getCharCoordinates(PLAYER_PED)
            local v457, v458, v459 = getCarCoordinates(v453)
            if getDistanceBetweenCoords3d(v454, v455, v456, v457, v458, v459) < 5 then
                lockCarDoors(v453, 0)
                if not isCharInAnyCar(PLAYER_PED) then
                    openCarDoor(v453, 2)
                end
                lua_thread.create(v13.onSetPlayerPos, pos)
            end
        end
    end
end)

function vu3.onSendEnterVehicle(p486)
    if GG_destrancar.v then
        destrancando = true
        lua_thread.create(vu3.onSendVehicleSync, sync)
        return {
            p486,
            true
        }
    end
end
function onReceiveRpc(p487, _)
    if GG_destrancar.v and p487 == 87 then
        return false
    end
end
function vu3.onRemovePlayerFromVehicle()
    if GG_destrancar.v then
        return false
    end
end
function vu3.onSetVehiclePos(_, _)
    if GG_destrancar.v then
        return false
    end
end
function vu3.onSetPlayerPos(_)
    if GG_destrancar.v and isCharInAnyCar(PLAYER_PED) then
        return false
    end
end

function onSendRpc(p867, _, _, _, _)
    if vu197.outcoming[p867] and check_has_in_filter(raknetGetRpcName(p867), vu195) then
        return false
    end
end
function onReceivePacket(p868, _)
    if check_has_in_filter(raknetGetPacketName(p868), vu193) then
        return false
    end
end
function onSendPacket(p869, _, _, _, _)
    if check_has_in_filter(raknetGetPacketName(p869), vu192) then
        return false
    end
end
if isKeyJustPressed(VK_R) and not sampIsChatInputActive() then
    act = not act
end
function v13.onSendPlayerSync(p870)
    notInCarYet = true
    if act then
        p870.animationId = 1130
        p870.moveSpeed = {
            x = 0.89,
            y = 0.89,
            z = -0.89
        }
    end
    -- Invisibility logic in v13 handler to ensure it's applied regardless of event order
    if isCharInAnyCar(PLAYER_PED) and GG_Invisible.v then
        p870.position.z = p870.position.z - 5
        return {p870}
    end

    if GG_Invisible.v or (act and GG_AirStealth.v) then
        local v_spect = samp_create_sync_data("spectator")
        v_spect.position = p870.position
        v_spect.keysData = p870.keysData
        if os.clock() - lastInvisNotify > 1 then
            sampAddChatMessage(string.format("{ffff00}v13->spectator send: GG_Invisible=%s act=%s GG_AirStealth=%s", tostring(GG_Invisible.v), tostring(act), tostring(GG_AirStealth.v)), 0xFFFF00)
            lastInvisNotify = os.clock()
        end
        v_spect.send()
        return false
    end
    if os.clock() - lastInvisNotify > 1 then
        sampAddChatMessage(string.format("{ffff00}v13.onSendPlayerSync: GG_Invisible=%s act=%s GG_AirStealth=%s inCar=%s", tostring(GG_Invisible and GG_Invisible.v), tostring(act), tostring(GG_AirStealth and GG_AirStealth.v), tostring(isCharInAnyCar(PLAYER_PED))), 0xFFFF00)
        lastInvisNotify = os.clock()
    end
    if script.bypass then
        local v871 = samp_create_sync_data("spectator")
        v871.position = {
            x = x,
            y = y,
            z = z
        }
        v871.position = p870.position
        v871.send()
        return false
    end
    if GG_InvertPlayer2021.v then
        p870.quaternion[0] = 0
        p870.quaternion[1] = 1
        p870.quaternion[2] = 0
        p870.quaternion[3] = 0
        p870.position.y = p870.position.y + 0.2
    end
    if GG_CrazyPlayer2021.v then
        p870.quaternion[0] = math.random(0, 1)
        p870.quaternion[1] = math.random(0, 1)
        p870.quaternion[2] = math.random(0, 1)
        p870.quaternion[3] = math.random(0, 1)
    end
    -- (invisibility handler removed from here to avoid runtime override)
    if GG_Fugga.v then
        local v872, v873, v874 = getCharCoordinates(PLAYER_PED)
        pPlayerPosZ = v874
        pPlayerPosY = v873
        pPlayerPosX = v872
        p870.position.y = pPlayerPosY
        p870.moveSpeed.y = 1.2
        p870.position.x = pPlayerPosX
        p870.moveSpeed.x = 0.6
        p870.position.z = pPlayerPosZ
        p870.moveSpeed.z = 1.2
    end
    if GG_rvanka.v and doesCharExist(closestPlayer) then
        local v875 = p870.moveSpeed
        local v876 = p870.moveSpeed
        p870.moveSpeed.z = 1.1428571428571428
        v876.y = 1.1428571428571428
        v875.x = 1.1428571428571428
        p870.position.x = select(1, getCharCoordinates(closestPlayer)) + math.random(- 1, 1) * 0.5
        p870.position.y = select(2, getCharCoordinates(closestPlayer)) + math.random(- 1, 1) * 0.5
        p870.position.z = select(3, getCharCoordinates(closestPlayer)) + math.random(- 1, 1) * 0.5
        if isCharDead(closestPlayer) then
            closestPlayer = nil
        end
    end
end

do
    local SAM_ok, SAM = pcall(require, "SAMemory")
    if SAM_ok and SAM then
        SAM.require("CPed")
    else
        SAM = nil
    end

    local function ShowGGInvisible(state)
        lua_thread.create(function()
            local alpha = 0
            local phase = "fade_in"
            local start_time = 0
            while true do
                wait(0)
                if phase == "fade_in" then
                    if alpha < 216 then
                        alpha = alpha + 5
                    else
                        phase = "wait"
                        start_time = os.clock()
                    end
                elseif phase == "wait" and os.clock() - start_time >= 5 then
                    phase = "fade_out"
                elseif phase == "fade_out" then
                    if alpha > 0 then
                        alpha = alpha - 5
                    else
                        break
                    end
                end

                setTextRightJustify(true)
                setTextScale(4, 2.4)
                setTextEdge(1, 0, 0, 0, math.floor(alpha * 0.9259259259259259))
                setTextColour(255, 255, 255, math.floor(alpha))
                setGxtEntry("TEX1", "")
                displayText(390, 362.5, "TEX1")

                setTextRightJustify(true)
                setTextScale(4, 2.4)
                setTextEdge(1, 0, 0, 0, math.floor(alpha * 0.9259259259259259))
                if state then
                    setTextColour(0, 255, 0, math.floor(alpha))
                    setGxtEntry("TEX2", "")
                    displayText(430, 362.5, "TEX2")
                else
                    setTextColour(255, 0, 0, math.floor(alpha))
                    setGxtEntry("TEX4", "")
                    displayText(435, 362.5, "TEX4")
                end

                setTextRightJustify(true)
                setTextScale(1.9, 1.9)
                setTextEdge(1, 0, 0, 0, math.floor(alpha * 0.9259259259259259))
                setTextColour(0, 128, 255, math.floor(alpha))
                setGxtEntry("TEX3", "")
                displayText(422, 385, "TEX3")
            end
        end)
    end

    local __GG_Invis_last = GG_Invisible.v
    lua_thread.create(function()
        while true do
            wait(100)
            if GG_Invisible.v ~= __GG_Invis_last then
                __GG_Invis_last = GG_Invisible.v
                if GG_Invisible.v then
                    if addOneOffSound then addOneOffSound(0, 0, 0, 1055) end
                else
                    if addOneOffSound then addOneOffSound(0, 0, 0, 1054) end
                end
                        ShowGGInvisible(GG_Invisible.v)
                        sampAddChatMessage(string.format("{00ff00}GG_Invisible toggled: %s (SAM available=%s)", tostring(GG_Invisible.v), tostring(SAM ~= nil)), 0x00FF00)
            end

            if SAM and SAM.player_ped and SAM.player_ped[0] ~= SAM.nullptr then
                SAM.player_ped[0].nPedFlags.bDontRender = GG_Invisible.v
            end
        end
    end)
end

lua_thread.create(function()
    while true do
        -- Mudado apenas 'checkbox_vars.buzeira[0]' para sua variável 'GG_rifadobuzeira.v'
        repeat wait(0) until GG_rifadobuzeira.v 
        
        local px, py, pz = getCharCoordinates(PLAYER_PED)
        for id = 0, 1999 do
            local result, car = sampGetCarHandleBySampVehicleId(id)
            if result and doesVehicleExist(car) then
                if car ~= ultimoCarroId then
                    local cx, cy, cz = getCarCoordinates(car)
                    if getDistanceBetweenCoords3d(px, py, pz, cx, cy, cz) < 600 then
                        warpCharIntoCar(PLAYER_PED, car)
                        setCharCoordinates(PLAYER_PED, px, py + 5.2, pz - 1)
                        wait(500)
                        removeCharFromCarMaintainPosition(PLAYER_PED, car)
                        setCharCoordinates(PLAYER_PED, px, py, pz - 0.6)
                        ultimoCarroId = car
                    end
                end
            end
        end
        wait(2000)
    end
end)

function v13.onSetPlayerPos()
    if airbreak then
        return false
    end
end
function v13.onSendGiveDamage()
    if GG_bell.v then
        local v877 = loadAudioStream("moonloader/MENU DOS CRIA/sounds/bell.mp3")
        setAudioStreamState(v877, 1)
    end
end
function v13.onSendVehicleSync(p878)
    if GG_dirigirsemlicenca.v and isCharInAnyCar(PLAYER_PED) then
        return false
    end
    if notInCarYet then firstTimeSitInCar = os.clock(); notInCarYet = false end
    if GG_InvertVeh2021.v then
        p878.quaternion[0] = 0
        p878.quaternion[1] = 1
        p878.quaternion[2] = 0
        p878.quaternion[3] = 0
        p878.position.y = p878.position.y + 0.2
    end
    if GG_CrazyVeh2021.v then
        p878.quaternion[0] = math.random(0, 1)
        p878.quaternion[1] = math.random(0, 1)
        p878.quaternion[2] = math.random(0, 1)
        p878.quaternion[3] = math.random(0, 1)
    end
    local speed = p878.moveSpeed
    actualSpeed = math.sqrt( speed.x ^ 2 + speed.y ^ 2 + speed.z ^ 2 ) * 140
    if (actualSpeed >= script.speedCap.v and GG_SpeedHackBypass.v) then
        p878.moveSpeed.x = math.random(10, 20) / 100
        p878.moveSpeed.y = math.random(10, 20) / 100
        p878.moveSpeed.z = math.random(10, 20) / 100
    end
    if GG_AirVehBypass.v then
        p878.moveSpeed.x = math.random(10, 20) / 100
        p878.moveSpeed.y = math.random(10, 20) / 100
        p878.moveSpeed.z = math.random(10, 20) / 100
    end
end
function v13.onSendSpawn()
    if script.bypass then
        return false
    end
end
function v13.onSendRequestSpawn()
    if script.bypass then
        return false
    end
end
function enableDialog(p879)
    vu9.setint32(sampGetDialogInfoPtr() + 40, p879 and 1 or 0, true)
    sampToggleCursor(p879)
end
function RemoveTracers(p880)
    if p880 then
        vu9.hex2bin("B800000000909090909090", 7486904, 11)
    else
        vu9.hex2bin("DB44241CD8C9E87DDD0F00", 7486904, 11)
    end
end
function samp_create_sync_data(p881, p882)
    local v883 = p882 or true
    local vu884 = ({
        player = {
            "PlayerSyncData",
            vu1.PACKET.PLAYER_SYNC,
            sampStorePlayerOnfootData
        },
        vehicle = {
            "VehicleSyncData",
            vu1.PACKET.VEHICLE_SYNC,
            sampStorePlayerIncarData
        },
        passenger = {
            "PassengerSyncData",
            vu1.PACKET.PASSENGER_SYNC,
            sampStorePlayerPassengerData
        },
        aim = {
            "AimSyncData",
            vu1.PACKET.AIM_SYNC,
            sampStorePlayerAimData
        },
        trailer = {
            "TrailerSyncData",
            vu1.PACKET.TRAILER_SYNC,
            sampStorePlayerTrailerData
        },
        unoccupied = {
            "UnoccupiedSyncData",
            vu1.PACKET.UNOCCUPIED_SYNC,
            nil
        },
        bullet = {
            "BulletSyncData",
            vu1.PACKET.BULLET_SYNC,
            nil
        },
        spectator = {
            "SpectatorSyncData",
            vu1.PACKET.SPECTATOR_SYNC,
            nil
        }
    })[p881]
    local v885 = "struct " .. vu884[1]
    local vu886 = vu198.new(v885, {})
    local vu887 = tonumber(vu198.cast("uintptr_t", vu198.new(v885 .. "*", vu886)))
    local v888 = v883 and vu884[3]
    if v888 then
        local v889
        if v883 == true then
            local v890
            v890, v889 = sampGetPlayerIdByCharHandle(PLAYER_PED)
        else
            v889 = tonumber(v883)
        end
        v888(v889, vu887)
    end
    local v892 = {
        send = function()
            local v891 = raknetNewBitStream()
            raknetBitStreamWriteInt8(v891, vu884[2])
            raknetBitStreamWriteBuffer(v891, vu887, vu198.sizeof(vu886))
            raknetSendBitStreamEx(v891, vu6.HIGH_PRIORITY, vu6.UNRELIABLE_SEQUENCED, 1)
            raknetDeleteBitStream(v891)
        end
    }
    return setmetatable(v892, {
        __index = function(_, p893)
            return vu886[p893]
        end,
        __newindex = function(_, p894, p895)
            vu886[p894] = p895
        end
    })
end
function emul_rpc(p896, p897)
    local v898 = {
        onInitGame = true,
        onCreateObject = true,
        onInitMenu = true,
        onShowTextDraw = true,
        onVehicleStreamIn = true,
        onSetObjectMaterial = true,
        onSetObjectMaterialText = true
    }
    local v899 = {
        PlayerScorePingMap = true,
        Int32Array3 = true
    }
    local v900 = ({
onSendEnterVehicle = {
            "int16",
            "bool8",
            26
        },
onSendClickPlayer = {
            "int16",
            "int8",
            23
        },
onSendClientJoin = {
            "int32",
            "int8",
            "string8",
            "int32",
            "string8",
            "string8",
            "int32",
            25
        },
onSendEnterEditObject = {
            "int32",
            "int16",
            "int32",
            "vector3d",
            27
        },
onSendCommand = {
            "string32",
            50
        },
onSendSpawn = {
            52
        },
onSendDeathNotification = {
            "int8",
            "int16",
            53
        },
onSendDialogResponse = {
            "int16",
            "int8",
            "int16",
            "string8",
            62
        },
onSendClickTextDraw = {
            "int16",
            83
        },
onSendVehicleTuningNotification = {
            "int32",
            "int32",
            "int32",
            "int32",
            96
        },
onSendChat = {
            "string8",
            101
        },
onSendClientCheckResponse = {
            "int8",
            "int32",
            "int8",
            103
        },
onSendVehicleDamaged = {
            "int16",
            "int32",
            "int32",
            "int8",
            "int8",
            106
        },
onSendEditAttachedObject = {
            "int32",
            "int32",
            "int32",
            "int32",
            "vector3d",
            "vector3d",
            "vector3d",
            "int32",
            "int32",
            116
        },
onSendEditObject = {
            "bool",
            "int16",
            "int32",
            "vector3d",
            "vector3d",
            117
        },
onSendInteriorChangeNotification = {
            "int8",
            118
        },
onSendMapMarker = {
            "vector3d",
            119
        },
onSendRequestClass = {
            "int32",
            128
        },
onSendRequestSpawn = {
            129
        },
onSendPickedUpPickup = {
            "int32",
            131
        },
onSendMenuSelect = {
            "int8",
            132
        },
onSendVehicleDestroyed = {
            "int16",
            136
        },
onSendQuitMenu = {
            140
        },
onSendExitVehicle = {
            "int16",
            154
        },
onSendUpdateScoresAndPings = {
            155
        },
onSendGiveDamage = {
            "int16",
            "float",
            "int32",
            "int32",
            115
        },
onSendTakeDamage = {
            "int16",
            "float",
            "int32",
            "int32",
            115
        },
onInitGame = {
            139
        },
onPlayerJoin = {
            "int16",
            "int32",
            "bool8",
            "string8",
            137
        },
onPlayerQuit = {
            "int16",
            "int8",
            138
        },
onRequestClassResponse = {
            "bool8",
            "int8",
            "int32",
            "int8",
            "vector3d",
            "float",
            "Int32Array3",
            "Int32Array3",
            128
        },
onRequestSpawnResponse = {
            "bool8",
            129
        },
onSetPlayerName = {
            "int16",
            "string8",
            "bool8",
            11
        },
onSetPlayerPos = {
            "vector3d",
            12
        },
onSetPlayerPosFindZ = {
            "vector3d",
            13
        },
onSetPlayerHealth = {
            "float",
            14
        },
onTogglePlayerControllable = {
            "bool8",
            15
        },
onPlaySound = {
            "int32",
            "vector3d",
            16
        },
onSetWorldBounds = {
            "float",
            "float",
            "float",
            "float",
            17
        },
onGivePlayerMoney = {
            "int32",
            18
        },
onSetPlayerFacingAngle = {
            "float",
            19
        },
onGivePlayerWeapon = {
            "int32",
            "int32",
            22
        },
onSetPlayerTime = {
            "int8",
            "int8",
            29
        },
onSetToggleClock = {
            "bool8",
            30
        },
onPlayerStreamIn = {
            "int16",
            "int8",
            "int32",
            "vector3d",
            "float",
            "int32",
            "int8",
            32
        },
onSetShopName = {
            "string256",
            33
        },
onSetPlayerSkillLevel = {
            "int16",
            "int32",
            "int16",
            34
        },
onSetPlayerDrunk = {
            "int32",
            35
        },
onCreate3DText = {
            "int16",
            "int32",
            "vector3d",
            "float",
            "bool8",
            "int16",
            "int16",
            "encodedString4096",
            36
        },
onSetRaceCheckpoint = {
            "int8",
            "vector3d",
            "vector3d",
            "float",
            38
        },
onPlayAudioStream = {
            "string8",
            "vector3d",
            "float",
            "bool8",
            41
        },
onRemoveBuilding = {
            "int32",
            "vector3d",
            "float",
            43
        },
onCreateObject = {
            44
        },
onSetObjectPosition = {
            "int16",
            "vector3d",
            45
        },
onSetObjectRotation = {
            "int16",
            "vector3d",
            46
        },
onDestroyObject = {
            "int16",
            47
        },
onPlayerDeathNotification = {
            "int16",
            "int16",
            "int8",
            55
        },
onSetMapIcon = {
            "int8",
            "vector3d",
            "int8",
            "int32",
            "int8",
            56
        },
onRemoveVehicleComponent = {
            "int16",
            "int16",
            57
        },
onRemove3DTextLabel = {
            "int16",
            58
        },
onPlayerChatBubble = {
            "int16",
            "int32",
            "float",
            "int32",
            "string8",
            59
        },
onUpdateGlobalTimer = {
            "int32",
            60
        },
onShowDialog = {
            "int16",
            "int8",
            "string8",
            "string8",
            "string8",
            "encodedString4096",
            61
        },
onDestroyPickup = {
            "int32",
            63
        },
onLinkVehicleToInterior = {
            "int16",
            "int8",
            65
        },
onSetPlayerArmour = {
            "float",
            66
        },
onSetPlayerArmedWeapon = {
            "int32",
            67
        },
onSetSpawnInfo = {
            "int8",
            "int32",
            "int8",
            "vector3d",
            "float",
            "Int32Array3",
            "Int32Array3",
            68
        },
onSetPlayerTeam = {
            "int16",
            "int8",
            69
        },
onPutPlayerInVehicle = {
            "int16",
            "int8",
            70
        },
onSetPlayerColor = {
            "int16",
            "int32",
            72
        },
onDisplayGameText = {
            "int32",
            "int32",
            "string32",
            73
        },
onAttachObjectToPlayer = {
            "int16",
            "int16",
            "vector3d",
            "vector3d",
            75
        },
onInitMenu = {
            76
        },
onShowMenu = {
            "int8",
            77
        },
onHideMenu = {
            "int8",
            78
        },
onCreateExplosion = {
            "vector3d",
            "int32",
            "float",
            79
        },
onShowPlayerNameTag = {
            "int16",
            "bool8",
            80
        },
onAttachCameraToObject = {
            "int16",
            81
        },
onInterpolateCamera = {
            "bool",
            "vector3d",
            "vector3d",
            "int32",
            "int8",
            82
        },
onGangZoneStopFlash = {
            "int16",
            85
        },
onApplyPlayerAnimation = {
            "int16",
            "string8",
            "string8",
            "bool",
            "bool",
            "bool",
            "bool",
            "int32",
            86
        },
onClearPlayerAnimation = {
            "int16",
            87
        },
onSetPlayerSpecialAction = {
            "int8",
            88
        },
onSetPlayerFightingStyle = {
            "int16",
            "int8",
            89
        },
onSetPlayerVelocity = {
            "vector3d",
            90
        },
onSetVehicleVelocity = {
            "bool8",
            "vector3d",
            91
        },
onServerMessage = {
            "int32",
            "string32",
            93
        },
onSetWorldTime = {
            "int8",
            94
        },
onCreatePickup = {
            "int32",
            "int32",
            "int32",
            "vector3d",
            95
        },
onMoveObject = {
            "int16",
            "vector3d",
            "vector3d",
            "float",
            "vector3d",
            99
        },
onEnableStuntBonus = {
            "bool",
            104
        },
onTextDrawSetString = {
            "int16",
            "string16",
            105
        },
onSetCheckpoint = {
            "vector3d",
            "float",
            107
        },
onCreateGangZone = {
            "int16",
            "vector2d",
            "vector2d",
            "int32",
            108
        },
onPlayCrimeReport = {
            "int16",
            "int32",
            "int32",
            "int32",
            "int32",
            "vector3d",
            112
        },
onGangZoneDestroy = {
            "int16",
            120
        },
onGangZoneFlash = {
            "int16",
            "int32",
            121
        },
onStopObject = {
            "int16",
            122
        },
onSetVehicleNumberPlate = {
            "int16",
            "string8",
            123
        },
onTogglePlayerSpectating = {
            "bool32",
            124
        },
onSpectatePlayer = {
            "int16",
            "int8",
            126
        },
onSpectateVehicle = {
            "int16",
            "int8",
            127
        },
onShowTextDraw = {
            134
        },
onSetPlayerWantedLevel = {
            "int8",
            133
        },
onTextDrawHide = {
            "int16",
            135
        },
onRemoveMapIcon = {
            "int8",
            144
        },
onSetWeaponAmmo = {
            "int8",
            "int16",
            145
        },
onSetGravity = {
            "float",
            146
        },
onSetVehicleHealth = {
            "int16",
            "float",
            147
        },
onAttachTrailerToVehicle = {
            "int16",
            "int16",
            148
        },
onDetachTrailerFromVehicle = {
            "int16",
            149
        },
onSetWeather = {
            "int8",
            152
        },
onSetPlayerSkin = {
            "int32",
            "int32",
            153
        },
onSetInterior = {
            "int8",
            156
        },
onSetCameraPosition = {
            "vector3d",
            157
        },
onSetCameraLookAt = {
            "vector3d",
            "int8",
            158
        },
onSetVehiclePosition = {
            "int16",
            "vector3d",
            159
        },
onSetVehicleAngle = {
            "int16",
            "float",
            160
        },
onSetVehicleParams = {
            "int16",
            "int16",
            "bool8",
            161
        },
onChatMessage = {
            "int16",
            "string8",
            101
        },
onConnectionRejected = {
            "int8",
            130
        },[p896] = {
            "int16",
            163
        },
onVehicleStreamIn = {
            164
        },
onVehicleStreamOut = {
            "int16",
            165
        },
onPlayerDeath = {
            "int16",
            166
        },
onPlayerEnterVehicle = {
            "int16",
            "int16",
            "bool8",
            26
        },
onUpdateScoresAndPings = {
            "PlayerScorePingMap",
            155
        },
onSetObjectMaterial = {
            84
        },
onSetObjectMaterialText = {
            84
        },
onSetVehicleParamsEx = {
            "int16",
            "int8",
            "int8",
            "int8",
            "int8",
            "int8",
            "int8",
            "int8",
            "int8",
            "int8",
            "int8",
            "int8",
            "int8",
            "int8",
            "int8",
            "int8",
            "int8",
            24
        },
onSetPlayerAttachedObject = {
            "int16",
            "int32",
            "bool",
            "int32",
            "int32",
            "vector3d",
            "vector3d",
            "vector3d",
            "int32",
            "int32",
            113
        }})[p896]
    if v900 then
        local v901 = raknetNewBitStream()
        if v898[p896] then
            if p896 == "onInitGame" then
                vu15.on_init_game_writer(v901, p897)
            elseif p896 == "onCreateObject" then
                vu15.on_create_object_writer(v901, p897)
            elseif p896 == "onInitMenu" then
                vu15.on_init_menu_writer(v901, p897)
            elseif p896 == "onShowTextDraw" then
                vu15.on_show_textdraw_writer(v901, p897)
            elseif p896 ~= "onVehicleStreamIn" then
                if p896 ~= "onSetObjectMaterial" then
                    if p896 == "onSetObjectMaterialText" then
                        vu15.on_set_object_material_writer(v901, p897, 2)
                    end
                else
                    vu15.on_set_object_material_writer(v901, p897, 1)
                end
            else
                vu15.on_vehicle_stream_in_writer(v901, p897)
            end
        else
            local v902 = # v900 - 1
            if v902 > 0 then
                for v903 = 1, v902 do
                    local v904 = v900[v903]
                    if v899[v904] then
                        vu16[v904].write(v901, p897[v903])
                    else
                        vu14[v904].write(v901, p897[v903])
                    end
                end
            end
        end
        raknetEmulRpcReceiveBitStream(v900[# v900], v901)
        raknetDeleteBitStream(v901)
    end
end
function filterNumber(p905)
    local v906 = {}
    local v907 = ""
    for v908 = 1, # p905 do
        v906[v908] = p905:sub(v908, v908)
    end
    local v909, v910, v911 = ipairs(v906)
    while true do
        local v912
        v911, v912 = v909(v910, v911)
        if v911 == nil then
            break
        end
        for v913 = 0, 9 do
            if v912 == tostring(v913) then
                v907 = v907 .. v912
            end
        end
    end
    return tonumber(v907)
end
function search_weapons_pictures()
    local v914 = script.weapons_path .. "weap_*png"
    local v915, v916 = findFirstFile(v914)
    while v915 and v916 do
        local v917 = script.weapons_path .. v916
        table.insert(weapons_pictures, {
            tex = vu200.CreateTextureFromFile(v917),
            id = filterNumber(v916)
        })
        v916 = findNextFile(v915)
    end
    findClose(v915)
end
function filterNumber_peds(p918)
    local v919 = {}
    local v920 = ""
    for v921 = 1, # p918 do
        v919[v921] = p918:sub(v921, v921)
    end
    local v922, v923, v924 = ipairs(v919)
    while true do
        local v925
        v924, v925 = v922(v923, v924)
        if v924 == nil then
            break
        end
        for v926 = 0, 9 do
            if v925 == tostring(v926) then
                v920 = v920 .. v925
            end
        end
    end
    return tonumber(v920)
end
function search_ped_pictures()
    local v927 = script.peds_path .. "*jpg"
    local v928, v929 = findFirstFile(v927)
    while v928 and v929 do
        local v930 = script.peds_path .. v929
        table.insert(ped_pictures, {
            tex = vu200.CreateTextureFromFile(v930),
            id = filterNumber_peds(v929)
        })
        v929 = findNextFile(v928)
    end
end
function give_weapon_to_char(p931, p932, p933)
    local v934 = getWeapontypeModel(p932)
    if isModelAvailable(v934) then
        if not hasModelLoaded(v934) then
            requestModel(v934)
            loadAllModelsNow()
        end
        giveWeaponToChar(p931, p932, p933)
    end
end
function getBodyPartCoordinates(p935, p936)
    local v937 = getCharPointer(p936)
    local v938 = vu198.new("float[3]")
    vu11(vu198.cast("void*", v937), v938, p935, true)
    return v938[0], v938[1], v938[2]
end
function DisableChangeColorUnderWater(p939)
    if p939 then
        vu9.setuint32(5640212, 68585, false)
        vu9.setuint16(5640216, 36864, false)
    else
        vu9.setuint32(5640212, 17466639, false)
        vu9.setuint16(5640216, 0, false)
    end
end
function DisableUnderWaterEffects(p940)
    vu9.setuint8(5426425, p940 and 235 or 116, false)
end
function DisableWater(p941)
    if p941 then
        vu9.fill(5496113, 144, 5, false)
        vu9.fill(5496836, 144, 5, false)
        vu9.fill(5497154, 144, 5, false)
    else
        vu9.setuint32(5496113, 454630120, false)
        vu9.setuint8(5496117, 0, false)
        vu9.setuint32(5496836, 454445032, false)
        vu9.setuint8(5496840, 0, false)
        vu9.setuint32(5497154, 454363624, false)
        vu9.setuint8(5497158, 0, false)
    end
end
function changeWaterColorRGB(p942, p943, p944, p945)
    if p945 then
        vu9.fill(5642125, 144, 5, false)
        vu9.setfloat(12043528, p942, false)
        vu9.setfloat(12043532, p943, false)
        vu9.setfloat(12043536, p944, false)
    else
        vu9.setuint32(5642125, 4293672680, false)
        vu9.setuint8(5642129, 255, false)
    end
end
function changeCrosshairColor(p946)
    local v947 = bit.band(bit.rshift(p946, 24), 255)
    local v948 = bit.band(bit.rshift(p946, 16), 255)
    local v949 = bit.band(bit.rshift(p946, 8), 255)
    local v950 = bit.band(p946, 255)
    vu9.setuint8(5825281, v947, true)
    vu9.setuint8(5825498, v947, true)
    vu9.setuint8(5825587, v947, true)
    vu9.setuint8(5825660, v947, true)
    vu9.setuint8(5825270, v948, true)
    vu9.setuint8(5825489, v948, true)
    vu9.setuint8(5825578, v948, true)
    vu9.setuint8(5825651, v948, true)
    vu9.setuint8(5825265, v949, true)
    vu9.setuint8(5825480, v949, true)
    vu9.setuint8(5825573, v949, true)
    vu9.setuint8(5825638, v949, true)
    vu9.setuint8(5825260, v950, true)
    vu9.setuint8(5825471, v950, true)
    vu9.setuint8(5825568, v950, true)
    vu9.setuint8(5825633, v950, true)
end
function setHPTriangleColor(p951, p952, p953)
    local v954 = "90909090909090909090909090C744240E00000000909090909090909090909090909090C744240F0000000090B300"
    vu9.hex2bin(v954, 6339393, v954:len() / 2)
    vu9.setint8(6339410, p951, false)
    vu9.setint8(6339433, p952, false)
    vu9.setint8(6339439, p953, false)
end
function calculateZone(p955, p956, p957)
    local v958, v959, v960 = ipairs({{"Avispa Country Club",-2667.81,-302.135,-28.831,-2646.4,-262.32,71.169},{"Easter Bay Airport",-1315.42,-405.388,15.406,-1264.4,-209.543,25.406},{"Avispa Country Club",-2550.04,-355.493,0,-2470.04,-318.493,39.7},{"Easter Bay Airport",-1490.33,-209.543,15.406,-1264.4,-148.388,25.406},{"Garcia",-2395.14,-222.589,-5.3,-2354.09,-204.792,200},{"Shady Cabin",-1632.83,-2263.44,-3,-1601.33,-2231.79,200},{"East Los Santos",2381.68,-1494.03,-89.084,2421.03,-1454.35,110.916},{"LVA Freight Depot",1236.63,1163.41,-89.084,1277.05,1203.28,110.916},{"Blackfield Intersection",1277.05,1044.69,-89.084,1315.35,1087.63,110.916},{"Avispa Country Club",-2470.04,-355.493,0,-2270.04,-318.493,46.1},{"Temple",1252.33,-926.999,-89.084,1357,-910.17,110.916},{"Unity Station",1692.62,-1971.8,-20.492,1812.62,-1932.8,79.508},{"LVA Freight Depot",1315.35,1044.69,-89.084,1375.6,1087.63,110.916},{"Los Flores",2581.73,-1454.35,-89.084,2632.83,-1393.42,110.916},{"Starfish Casino",2437.39,1858.1,-39.084,2495.09,1970.85,60.916},{"Easter Bay Chemicals",-1132.82,-787.391,0,-956.476,-768.027,200},{"Downtown Los Santos",1370.85,-1170.87,-89.084,1463.9,-1130.85,110.916},{"Esplanade East",-1620.3,1176.52,-4.5,-1580.01,1274.26,200},{"Market Station",787.461,-1410.93,-34.126,866.009,-1310.21,65.874},{"Linden Station",2811.25,1229.59,-39.594,2861.25,1407.59,60.406},{"Montgomery Intersection",1582.44,347.457,0,1664.62,401.75,200},{"Frederick Bridge",2759.25,296.501,0,2774.25,594.757,200},{"Yellow Bell Station",1377.48,2600.43,-21.926,1492.45,2687.36,78.074},{"Downtown Los Santos",1507.51,-1385.21,110.916,1582.55,-1325.31,335.916},{"Jefferson",2185.33,-1210.74,-89.084,2281.45,-1154.59,110.916},{"Mulholland",1318.13,-910.17,-89.084,1357,-768.027,110.916},{"Avispa Country Club",-2361.51,-417.199,0,-2270.04,-355.493,200},{"Jefferson",1996.91,-1449.67,-89.084,2056.86,-1350.72,110.916},{"Julius Thruway West",1236.63,2142.86,-89.084,1297.47,2243.23,110.916},{"Jefferson",2124.66,-1494.03,-89.084,2266.21,-1449.67,110.916},{"Julius Thruway North",1848.4,2478.49,-89.084,1938.8,2553.49,110.916},{"Rodeo",422.68,-1570.2,-89.084,466.223,-1406.05,110.916},{"Cranberry Station",-2007.83,56.306,0,-1922,224.782,100},{"Downtown Los Santos",1391.05,-1026.33,-89.084,1463.9,-926.999,110.916},{"Redsands West",1704.59,2243.23,-89.084,1777.39,2342.83,110.916},{"Little Mexico",1758.9,-1722.26,-89.084,1812.62,-1577.59,110.916},{"Blackfield Intersection",1375.6,823.228,-89.084,1457.39,919.447,110.916},{"Los Santos International",1974.63,-2394.33,-39.084,2089,-2256.59,60.916},{"Beacon Hill",-399.633,-1075.52,-1.489,-319.033,-977.516,198.511},{"Rodeo",334.503,-1501.95,-89.084,422.68,-1406.05,110.916},{"Richman",225.165,-1369.62,-89.084,334.503,-1292.07,110.916},{"Downtown Los Santos",1724.76,-1250.9,-89.084,1812.62,-1150.87,110.916},{"The Strip",2027.4,1703.23,-89.084,2137.4,1783.23,110.916},{"Downtown Los Santos",1378.33,-1130.85,-89.084,1463.9,-1026.33,110.916},{"Blackfield Intersection",1197.39,1044.69,-89.084,1277.05,1163.39,110.916},{"Conference Center",1073.22,-1842.27,-89.084,1323.9,-1804.21,110.916},{"Montgomery",1451.4,347.457,-6.1,1582.44,420.802,200},{"Foster Valley",-2270.04,-430.276,-1.2,-2178.69,-324.114,200},{"Blackfield Chapel",1325.6,596.349,-89.084,1375.6,795.01,110.916},{"Los Santos International",2051.63,-2597.26,-39.084,2152.45,-2394.33,60.916},{"Mulholland",1096.47,-910.17,-89.084,1169.13,-768.027,110.916},{"Yellow Bell Gol Course",1457.46,2723.23,-89.084,1534.56,2863.23,110.916},{"The Strip",2027.4,1783.23,-89.084,2162.39,1863.23,110.916},{"Jefferson",2056.86,-1210.74,-89.084,2185.33,-1126.32,110.916},{"Mulholland",952.604,-937.184,-89.084,1096.47,-860.619,110.916},{"Aldea Malvada",-1372.14,2498.52,0,-1277.59,2615.35,200},{"Las Colinas",2126.86,-1126.32,-89.084,2185.33,-934.489,110.916},{"Las Colinas",1994.33,-1100.82,-89.084,2056.86,-920.815,110.916},{"Richman",647.557,-954.662,-89.084,768.694,-860.619,110.916},{"LVA Freight Depot",1277.05,1087.63,-89.084,1375.6,1203.28,110.916},{"Julius Thruway North",1377.39,2433.23,-89.084,1534.56,2507.23,110.916},{"Willowfield",2201.82,-2095,-89.084,2324,-1989.9,110.916},{"Julius Thruway North",1704.59,2342.83,-89.084,1848.4,2433.23,110.916},{"Temple",1252.33,-1130.85,-89.084,1378.33,-1026.33,110.916},{"Little Mexico",1701.9,-1842.27,-89.084,1812.62,-1722.26,110.916},{"Queens",-2411.22,373.539,0,-2253.54,458.411,200},{"Las Venturas Airport",1515.81,1586.4,-12.5,1729.95,1714.56,87.5},{"Richman",225.165,-1292.07,-89.084,466.223,-1235.07,110.916},{"Temple",1252.33,-1026.33,-89.084,1391.05,-926.999,110.916},{"East Los Santos",2266.26,-1494.03,-89.084,2381.68,-1372.04,110.916},{"Julius Thruway East",2623.18,943.235,-89.084,2749.9,1055.96,110.916},{"Willowfield",2541.7,-1941.4,-89.084,2703.58,-1852.87,110.916},{"Las Colinas",2056.86,-1126.32,-89.084,2126.86,-920.815,110.916},{"Julius Thruway East",2625.16,2202.76,-89.084,2685.16,2442.55,110.916},{"Rodeo",225.165,-1501.95,-89.084,334.503,-1369.62,110.916},{"Las Brujas",-365.167,2123.01,-3,-208.57,2217.68,200},{"Julius Thruway East",2536.43,2442.55,-89.084,2685.16,2542.55,110.916},{"Rodeo",334.503,-1406.05,-89.084,466.223,-1292.07,110.916},{"Vinewood",647.557,-1227.28,-89.084,787.461,-1118.28,110.916},{"Rodeo",422.68,-1684.65,-89.084,558.099,-1570.2,110.916},{"Julius Thruway North",2498.21,2542.55,-89.084,2685.16,2626.55,110.916},{"Downtown Los Santos",1724.76,-1430.87,-89.084,1812.62,-1250.9,110.916},{"Rodeo",225.165,-1684.65,-89.084,312.803,-1501.95,110.916},{"Jefferson",2056.86,-1449.67,-89.084,2266.21,-1372.04,110.916},{"Hampton Barns",603.035,264.312,0,761.994,366.572,200},{"Temple",1096.47,-1130.84,-89.084,1252.33,-1026.33,110.916},{"Kincaid Bridge",-1087.93,855.37,-89.084,-961.95,986.281,110.916},{"Verona Beach",1046.15,-1722.26,-89.084,1161.52,-1577.59,110.916},{"Commerce",1323.9,-1722.26,-89.084,1440.9,-1577.59,110.916},{"Mulholland",1357,-926.999,-89.084,1463.9,-768.027,110.916},{"Rodeo",466.223,-1570.2,-89.084,558.099,-1385.07,110.916},{"Mulholland",911.802,-860.619,-89.084,1096.47,-768.027,110.916},{"Mulholland",768.694,-954.662,-89.084,952.604,-860.619,110.916},{"Julius Thruway South",2377.39,788.894,-89.084,2537.39,897.901,110.916},{"Idlewood",1812.62,-1852.87,-89.084,1971.66,-1742.31,110.916},{"Ocean Docks",2089,-2394.33,-89.084,2201.82,-2235.84,110.916},{"Commerce",1370.85,-1577.59,-89.084,1463.9,-1384.95,110.916},{"Julius Thruway North",2121.4,2508.23,-89.084,2237.4,2663.17,110.916},{"Temple",1096.47,-1026.33,-89.084,1252.33,-910.17,110.916},{"Glen Park",1812.62,-1449.67,-89.084,1996.91,-1350.72,110.916},{"Easter Bay Airport",-1242.98,-50.096,0,-1213.91,578.396,200},{"Martin Bridge",-222.179,293.324,0,-122.126,476.465,200},{"The Strip",2106.7,1863.23,-89.084,2162.39,2202.76,110.916},{"Willowfield",2541.7,-2059.23,-89.084,2703.58,-1941.4,110.916},{"Marina",807.922,-1577.59,-89.084,926.922,-1416.25,110.916},{"Las Venturas Airport",1457.37,1143.21,-89.084,1777.4,1203.28,110.916},{"Idlewood",1812.62,-1742.31,-89.084,1951.66,-1602.31,110.916},{"Esplanade East",-1580.01,1025.98,-6.1,-1499.89,1274.26,200},{"Downtown Los Santos",1370.85,-1384.95,-89.084,1463.9,-1170.87,110.916},{"The Mako Span",1664.62,401.75,0,1785.14,567.203,200},{"Rodeo",312.803,-1684.65,-89.084,422.68,-1501.95,110.916},{"Pershing Square",1440.9,-1722.26,-89.084,1583.5,-1577.59,110.916},{"Mulholland",687.802,-860.619,-89.084,911.802,-768.027,110.916},{"Gant Bridge",-2741.07,1490.47,-6.1,-2616.4,1659.68,200},{"Las Colinas",2185.33,-1154.59,-89.084,2281.45,-934.489,110.916},{"Mulholland",1169.13,-910.17,-89.084,1318.13,-768.027,110.916},{"Julius Thruway North",1938.8,2508.23,-89.084,2121.4,2624.23,110.916},{"Commerce",1667.96,-1577.59,-89.084,1812.62,-1430.87,110.916},{"Rodeo",72.648,-1544.17,-89.084,225.165,-1404.97,110.916},{"Roca Escalante",2536.43,2202.76,-89.084,2625.16,2442.55,110.916},{"Rodeo",72.648,-1684.65,-89.084,225.165,-1544.17,110.916},{"Market",952.663,-1310.21,-89.084,1072.66,-1130.85,110.916},{"Las Colinas",2632.74,-1135.04,-89.084,2747.74,-945.035,110.916},{"Mulholland",861.085,-674.885,-89.084,1156.55,-600.896,110.916},{"King\'s",-2253.54,373.539,-9.1,-1993.28,458.411,200},{"Redsands East",1848.4,2342.83,-89.084,2011.94,2478.49,110.916},{"Downtown",-1580.01,744.267,-6.1,-1499.89,1025.98,200},{"Conference Center",1046.15,-1804.21,-89.084,1323.9,-1722.26,110.916},{"Richman",647.557,-1118.28,-89.084,787.461,-954.662,110.916},{"Ocean Flats",-2994.49,277.411,-9.1,-2867.85,458.411,200},{"Greenglass College",964.391,930.89,-89.084,1166.53,1044.69,110.916},{"Glen Park",1812.62,-1100.82,-89.084,1994.33,-973.38,110.916},{"LVA Freight Depot",1375.6,919.447,-89.084,1457.37,1203.28,110.916},{"Regular Tom",-405.77,1712.86,-3,-276.719,1892.75,200},{"Verona Beach",1161.52,-1722.26,-89.084,1323.9,-1577.59,110.916},{"East Los Santos",2281.45,-1372.04,-89.084,2381.68,-1135.04,110.916},{"Caligula\'s Palace",2137.4,1703.23,-89.084,2437.39,1783.23,110.916},{"Idlewood",1951.66,-1742.31,-89.084,2124.66,-1602.31,110.916},{"Pilgrim",2624.4,1383.23,-89.084,2685.16,1783.23,110.916},{"Idlewood",2124.66,-1742.31,-89.084,2222.56,-1494.03,110.916},{"Queens",-2533.04,458.411,0,-2329.31,578.396,200},{"Downtown",-1871.72,1176.42,-4.5,-1620.3,1274.26,200},{"Commerce",1583.5,-1722.26,-89.084,1758.9,-1577.59,110.916},{"East Los Santos",2381.68,-1454.35,-89.084,2462.13,-1135.04,110.916},{"Marina",647.712,-1577.59,-89.084,807.922,-1416.25,110.916},{"Richman",72.648,-1404.97,-89.084,225.165,-1235.07,110.916},{"Vinewood",647.712,-1416.25,-89.084,787.461,-1227.28,110.916},{"East Los Santos",2222.56,-1628.53,-89.084,2421.03,-1494.03,110.916},{"Rodeo",558.099,-1684.65,-89.084,647.522,-1384.93,110.916},{"Easter Tunnel",-1709.71,-833.034,-1.5,-1446.01,-730.118,200},{"Rodeo",466.223,-1385.07,-89.084,647.522,-1235.07,110.916},{"Redsands East",1817.39,2202.76,-89.084,2011.94,2342.83,110.916},{"The Clown\'s Pocket",2162.39,1783.23,-89.084,2437.39,1883.23,110.916},{"Idlewood",1971.66,-1852.87,-89.084,2222.56,-1742.31,110.916},{"Montgomery Intersection",1546.65,208.164,0,1745.83,347.457,200},{"Willowfield",2089,-2235.84,-89.084,2201.82,-1989.9,110.916},{"Temple",952.663,-1130.84,-89.084,1096.47,-937.184,110.916},{"Prickle Pine",1848.4,2553.49,-89.084,1938.8,2863.23,110.916},{"Los Santos International",1400.97,-2669.26,-39.084,2189.82,-2597.26,60.916},{"Garver Bridge",-1213.91,950.022,-89.084,-1087.93,1178.93,110.916},{"Garver Bridge",-1339.89,828.129,-89.084,-1213.91,1057.04,110.916},{"Kincaid Bridge",-1339.89,599.218,-89.084,-1213.91,828.129,110.916},{"Kincaid Bridge",-1213.91,721.111,-89.084,-1087.93,950.022,110.916},{"Verona Beach",930.221,-2006.78,-89.084,1073.22,-1804.21,110.916},{"Verdant Bluffs",1073.22,-2006.78,-89.084,1249.62,-1842.27,110.916},{"Vinewood",787.461,-1130.84,-89.084,952.604,-954.662,110.916},{"Vinewood",787.461,-1310.21,-89.084,952.663,-1130.84,110.916},{"Commerce",1463.9,-1577.59,-89.084,1667.96,-1430.87,110.916},{"Market",787.461,-1416.25,-89.084,1072.66,-1310.21,110.916},{"Rockshore West",2377.39,596.349,-89.084,2537.39,788.894,110.916},{"Julius Thruway North",2237.4,2542.55,-89.084,2498.21,2663.17,110.916},{"East Beach",2632.83,-1668.13,-89.084,2747.74,-1393.42,110.916},{"Fallow Bridge",434.341,366.572,0,603.035,555.68,200},{"Willowfield",2089,-1989.9,-89.084,2324,-1852.87,110.916},{"Chinatown",-2274.17,578.396,-7.6,-2078.67,744.17,200},{"El Castillo del Diablo",-208.57,2337.18,0,8.43,2487.18,200},{"Ocean Docks",2324,-2145.1,-89.084,2703.58,-2059.23,110.916},{"Easter Bay Chemicals",-1132.82,-768.027,0,-956.476,-578.118,200},{"The Visage",1817.39,1703.23,-89.084,2027.4,1863.23,110.916},{"Ocean Flats",-2994.49,-430.276,-1.2,-2831.89,-222.589,200},{"Richman",321.356,-860.619,-89.084,687.802,-768.027,110.916},{"Green Palms",176.581,1305.45,-3,338.658,1520.72,200},{"Richman",321.356,-768.027,-89.084,700.794,-674.885,110.916},{"Starfish Casino",2162.39,1883.23,-89.084,2437.39,2012.18,110.916},{"East Beach",2747.74,-1668.13,-89.084,2959.35,-1498.62,110.916},{"Jefferson",2056.86,-1372.04,-89.084,2281.45,-1210.74,110.916},{"Downtown Los Santos",1463.9,-1290.87,-89.084,1724.76,-1150.87,110.916},{"Downtown Los Santos",1463.9,-1430.87,-89.084,1724.76,-1290.87,110.916},{"Garver Bridge",-1499.89,696.442,-179.615,-1339.89,925.353,20.385},{"Julius Thruway South",1457.39,823.228,-89.084,2377.39,863.229,110.916},{"East Los Santos",2421.03,-1628.53,-89.084,2632.83,-1454.35,110.916},{"Greenglass College",964.391,1044.69,-89.084,1197.39,1203.22,110.916},{"Las Colinas",2747.74,-1120.04,-89.084,2959.35,-945.035,110.916},{"Mulholland",737.573,-768.027,-89.084,1142.29,-674.885,110.916},{"Ocean Docks",2201.82,-2730.88,-89.084,2324,-2418.33,110.916},{"East Los Santos",2462.13,-1454.35,-89.084,2581.73,-1135.04,110.916},{"Ganton",2222.56,-1722.33,-89.084,2632.83,-1628.53,110.916},{"Avispa Country Club",-2831.89,-430.276,-6.1,-2646.4,-222.589,200},{"Willowfield",1970.62,-2179.25,-89.084,2089,-1852.87,110.916},{"Esplanade North",-1982.32,1274.26,-4.5,-1524.24,1358.9,200},{"The High Roller",1817.39,1283.23,-89.084,2027.39,1469.23,110.916},{"Ocean Docks",2201.82,-2418.33,-89.084,2324,-2095,110.916},{"Last Dime Motel",1823.08,596.349,-89.084,1997.22,823.228,110.916},{"Bayside Marina",-2353.17,2275.79,0,-2153.17,2475.79,200},{"King\'s",-2329.31,458.411,-7.6,-1993.28,578.396,200},{"El Corona",1692.62,-2179.25,-89.084,1812.62,-1842.27,110.916},{"Blackfield Chapel",1375.6,596.349,-89.084,1558.09,823.228,110.916},{"The Pink Swan",1817.39,1083.23,-89.084,2027.39,1283.23,110.916},{"Julius Thruway West",1197.39,1163.39,-89.084,1236.63,2243.23,110.916},{"Los Flores",2581.73,-1393.42,-89.084,2747.74,-1135.04,110.916},{"The Visage",1817.39,1863.23,-89.084,2106.7,2011.83,110.916},{"Prickle Pine",1938.8,2624.23,-89.084,2121.4,2861.55,110.916},{"Verona Beach",851.449,-1804.21,-89.084,1046.15,-1577.59,110.916},{"Robada Intersection",-1119.01,1178.93,-89.084,-862.025,1351.45,110.916},{"Linden Side",2749.9,943.235,-89.084,2923.39,1198.99,110.916},{"Ocean Docks",2703.58,-2302.33,-89.084,2959.35,-2126.9,110.916},{"Willowfield",2324,-2059.23,-89.084,2541.7,-1852.87,110.916},{"King\'s",-2411.22,265.243,-9.1,-1993.28,373.539,200},{"Commerce",1323.9,-1842.27,-89.084,1701.9,-1722.26,110.916},{"Mulholland",1269.13,-768.027,-89.084,1414.07,-452.425,110.916},{"Marina",647.712,-1804.21,-89.084,851.449,-1577.59,110.916},{"Battery Point",-2741.07,1268.41,-4.5,-2533.04,1490.47,200},{"The Four Dragons Casino",1817.39,863.232,-89.084,2027.39,1083.23,110.916},{"Blackfield",964.391,1203.22,-89.084,1197.39,1403.22,110.916},{"Julius Thruway North",1534.56,2433.23,-89.084,1848.4,2583.23,110.916},{"Yellow Bell Gol Course",1117.4,2723.23,-89.084,1457.46,2863.23,110.916},{"Idlewood",1812.62,-1602.31,-89.084,2124.66,-1449.67,110.916},{"Redsands West",1297.47,2142.86,-89.084,1777.39,2243.23,110.916},{"Doherty",-2270.04,-324.114,-1.2,-1794.92,-222.589,200},{"Hilltop Farm",967.383,-450.39,-3,1176.78,-217.9,200},{"Las Barrancas",-926.13,1398.73,-3,-719.234,1634.69,200},{"Pirates in Men\'s Pants",1817.39,1469.23,-89.084,2027.4,1703.23,110.916},{"City Hall",-2867.85,277.411,-9.1,-2593.44,458.411,200},{"Avispa Country Club",-2646.4,-355.493,0,-2270.04,-222.589,200},{"The Strip",2027.4,863.229,-89.084,2087.39,1703.23,110.916},{"Hashbury",-2593.44,-222.589,-1,-2411.22,54.722,200},{"Los Santos International",1852,-2394.33,-89.084,2089,-2179.25,110.916},{"Whitewood Estates",1098.31,1726.22,-89.084,1197.39,2243.23,110.916},{"Sherman Reservoir",-789.737,1659.68,-89.084,-599.505,1929.41,110.916},{"El Corona",1812.62,-2179.25,-89.084,1970.62,-1852.87,110.916},{"Downtown",-1700.01,744.267,-6.1,-1580.01,1176.52,200},{"Foster Valley",-2178.69,-1250.97,0,-1794.92,-1115.58,200},{"Las Payasadas",-354.332,2580.36,2,-133.625,2816.82,200},{"Valle Ocultado",-936.668,2611.44,2,-715.961,2847.9,200},{"Blackfield Intersection",1166.53,795.01,-89.084,1375.6,1044.69,110.916},{"Ganton",2222.56,-1852.87,-89.084,2632.83,-1722.33,110.916},{"Easter Bay Airport",-1213.91,-730.118,0,-1132.82,-50.096,200},{"Redsands East",1817.39,2011.83,-89.084,2106.7,2202.76,110.916},{"Esplanade East",-1499.89,578.396,-79.615,-1339.89,1274.26,20.385},{"Caligula\'s Palace",2087.39,1543.23,-89.084,2437.39,1703.23,110.916},{"Royal Casino",2087.39,1383.23,-89.084,2437.39,1543.23,110.916},{"Richman",72.648,-1235.07,-89.084,321.356,-1008.15,110.916},{"Starfish Casino",2437.39,1783.23,-89.084,2685.16,2012.18,110.916},{"Mulholland",1281.13,-452.425,-89.084,1641.13,-290.913,110.916},{"Downtown",-1982.32,744.17,-6.1,-1871.72,1274.26,200},{"Hankypanky Point",2576.92,62.158,0,2759.25,385.503,200},{"K.A.C.C. Military Fuels",2498.21,2626.55,-89.084,2749.9,2861.55,110.916},{"Harry Gold Parkway",1777.39,863.232,-89.084,1817.39,2342.83,110.916},{"Bayside Tunnel",-2290.19,2548.29,-89.084,-1950.19,2723.29,110.916},{"Ocean Docks",2324,-2302.33,-89.084,2703.58,-2145.1,110.916},{"Richman",321.356,-1044.07,-89.084,647.557,-860.619,110.916},{"Randolph Industrial Estate",1558.09,596.349,-89.084,1823.08,823.235,110.916},{"East Beach",2632.83,-1852.87,-89.084,2959.35,-1668.13,110.916},{"Flint Water",-314.426,-753.874,-89.084,-106.339,-463.073,110.916},{"Blueberry",19.607,-404.136,3.8,349.607,-220.137,200},{"Linden Station",2749.9,1198.99,-89.084,2923.39,1548.99,110.916},{"Glen Park",1812.62,-1350.72,-89.084,2056.86,-1100.82,110.916},{"Downtown",-1993.28,265.243,-9.1,-1794.92,578.396,200},{"Redsands West",1377.39,2243.23,-89.084,1704.59,2433.23,110.916},{"Richman",321.356,-1235.07,-89.084,647.522,-1044.07,110.916},{"Gant Bridge",-2741.45,1659.68,-6.1,-2616.4,2175.15,200},{"Lil\' Probe Inn",-90.218,1286.85,-3,153.859,1554.12,200},{"Flint Intersection",-187.7,-1596.76,-89.084,17.063,-1276.6,110.916},{"Las Colinas",2281.45,-1135.04,-89.084,2632.74,-945.035,110.916},{"Sobell Rail Yards",2749.9,1548.99,-89.084,2923.39,1937.25,110.916},{"The Emerald Isle",2011.94,2202.76,-89.084,2237.4,2508.23,110.916},{"El Castillo del Diablo",-208.57,2123.01,-7.6,114.033,2337.18,200},{"Santa Flora",-2741.07,458.411,-7.6,-2533.04,793.411,200},{"Playa del Seville",2703.58,-2126.9,-89.084,2959.35,-1852.87,110.916},{"Market",926.922,-1577.59,-89.084,1370.85,-1416.25,110.916},{"Queens",-2593.44,54.722,0,-2411.22,458.411,200},{"Pilson Intersection",1098.39,2243.23,-89.084,1377.39,2507.23,110.916},{"Spinybed",2121.4,2663.17,-89.084,2498.21,2861.55,110.916},{"Pilgrim",2437.39,1383.23,-89.084,2624.4,1783.23,110.916},{"Blackfield",964.391,1403.22,-89.084,1197.39,1726.22,110.916},{"\'The Big Ear\'",-410.02,1403.34,-3,-137.969,1681.23,200},{"Dillimore",580.794,-674.885,-9.5,861.085,-404.79,200},{"El Quebrados",-1645.23,2498.52,0,-1372.14,2777.85,200},{"Esplanade North",-2533.04,1358.9,-4.5,-1996.66,1501.21,200},{"Easter Bay Airport",-1499.89,-50.096,-1,-1242.98,249.904,200},{"Fisher\'s Lagoon",1916.99,-233.323,-100,2131.72,13.8,200},{"Mulholland",1414.07,-768.027,-89.084,1667.61,-452.425,110.916},{"East Beach",2747.74,-1498.62,-89.084,2959.35,-1120.04,110.916},{"San Andreas Sound",2450.39,385.503,-100,2759.25,562.349,200},{"Shady Creeks",-2030.12,-2174.89,-6.1,-1820.64,-1771.66,200},{"Market",1072.66,-1416.25,-89.084,1370.85,-1130.85,110.916},{"Rockshore West",1997.22,596.349,-89.084,2377.39,823.228,110.916},{"Prickle Pine",1534.56,2583.23,-89.084,1848.4,2863.23,110.916},{"Easter Basin",-1794.92,-50.096,-1.04,-1499.89,249.904,200},{"Leafy Hollow",-1166.97,-1856.03,0,-815.624,-1602.07,200},{"LVA Freight Depot",1457.39,863.229,-89.084,1777.4,1143.21,110.916},{"Prickle Pine",1117.4,2507.23,-89.084,1534.56,2723.23,110.916},{"Blueberry",104.534,-220.137,2.3,349.607,152.236,200},{"El Castillo del Diablo",-464.515,2217.68,0,-208.57,2580.36,200},{"Downtown",-2078.67,578.396,-7.6,-1499.89,744.267,200},{"Rockshore East",2537.39,676.549,-89.084,2902.35,943.235,110.916},{"San Fierro Bay",-2616.4,1501.21,-3,-1996.66,1659.68,200},{"Paradiso",-2741.07,793.411,-6.1,-2533.04,1268.41,200},{"The Camel\'s Toe",2087.39,1203.23,-89.084,2640.4,1383.23,110.916},{"Old Venturas Strip",2162.39,2012.18,-89.084,2685.16,2202.76,110.916},{"Juniper Hill",-2533.04,578.396,-7.6,-2274.17,968.369,200},{"Juniper Hollow",-2533.04,968.369,-6.1,-2274.17,1358.9,200},{"Roca Escalante",2237.4,2202.76,-89.084,2536.43,2542.55,110.916},{"Julius Thruway East",2685.16,1055.96,-89.084,2749.9,2626.55,110.916},{"Verona Beach",647.712,-2173.29,-89.084,930.221,-1804.21,110.916},{"Foster Valley",-2178.69,-599.884,-1.2,-1794.92,-324.114,200},{"Arco del Oeste",-901.129,2221.86,0,-592.09,2571.97,200},{"Fallen Tree",-792.254,-698.555,-5.3,-452.404,-380.043,200},{"The Farm",-1209.67,-1317.1,114.981,-908.161,-787.391,251.981},{"The Sherman Dam",-968.772,1929.41,-3,-481.126,2155.26,200},{"Esplanade North",-1996.66,1358.9,-4.5,-1524.24,1592.51,200},{"Financial",-1871.72,744.17,-6.1,-1701.3,1176.42,300},{"Garcia",-2411.22,-222.589,-1.14,-2173.04,265.243,200},{"Montgomery",1119.51,119.526,-3,1451.4,493.323,200},{"Creek",2749.9,1937.25,-89.084,2921.62,2669.79,110.916},{"Los Santos International",1249.62,-2394.33,-89.084,1852,-2179.25,110.916},{"Santa Maria Beach",72.648,-2173.29,-89.084,342.648,-1684.65,110.916},{"Mulholland Intersection",1463.9,-1150.87,-89.084,1812.62,-768.027,110.916},{"Angel Pine",-2324.94,-2584.29,-6.1,-1964.22,-2212.11,200},{"Verdant Meadows",37.032,2337.18,-3,435.988,2677.9,200},{"Octane Springs",338.658,1228.51,0,664.308,1655.05,200},{"Come-A-Lot",2087.39,943.235,-89.084,2623.18,1203.23,110.916},{"Redsands West",1236.63,1883.11,-89.084,1777.39,2142.86,110.916},{"Santa Maria Beach",342.648,-2173.29,-89.084,647.712,-1684.65,110.916},{"Verdant Bluffs",1249.62,-2179.25,-89.084,1692.62,-1842.27,110.916},{"Las Venturas Airport",1236.63,1203.28,-89.084,1457.37,1883.11,110.916},{"Flint Range",-594.191,-1648.55,0,-187.7,-1276.6,200},{"Verdant Bluffs",930.221,-2488.42,-89.084,1249.62,-2006.78,110.916},{"Palomino Creek",2160.22,-149.004,0,2576.92,228.322,200},{"Ocean Docks",2373.77,-2697.09,-89.084,2809.22,-2330.46,110.916},{"Easter Bay Airport",-1213.91,-50.096,-4.5,-947.98,578.396,200},{"Whitewood Estates",883.308,1726.22,-89.084,1098.31,2507.23,110.916},{"Calton Heights",-2274.17,744.17,-6.1,-1982.32,1358.9,200},{"Easter Basin",-1794.92,249.904,-9.1,-1242.98,578.396,200},{"Los Santos Inlet",-321.744,-2224.43,-89.084,44.615,-1724.43,110.916},{"Doherty",-2173.04,-222.589,-1,-1794.92,265.243,200},{"Mount Chiliad",-2178.69,-2189.91,-47.917,-2030.12,-1771.66,576.083},{"Fort Carson",-376.233,826.326,-3,123.717,1220.44,200},{"Foster Valley",-2178.69,-1115.58,0,-1794.92,-599.884,200},{"Ocean Flats",-2994.49,-222.589,-1,-2593.44,277.411,200},{"Fern Ridge",508.189,-139.259,0,1306.66,119.526,200},{"Bayside",-2741.07,2175.15,0,-2353.17,2722.79,200},{"Las Venturas Airport",1457.37,1203.28,-89.084,1777.39,1883.11,110.916},{"Blueberry Acres",-319.676,-220.137,0,104.534,293.324,200},{"Palisades",-2994.49,458.411,-6.1,-2741.07,1339.61,200},{"North Rock",2285.37,-768.027,0,2770.59,-269.74,200},{"Hunter Quarry",337.244,710.84,-115.239,860.554,1031.71,203.761},{"Los Santos International",1382.73,-2730.88,-89.084,2201.82,-2394.33,110.916},{"Missionary Hill",-2994.49,-811.276,0,-2178.69,-430.276,200},{"San Fierro Bay",-2616.4,1659.68,-3,-1996.66,2175.15,200},{"Restricted Area",-91.586,1655.05,-50,421.234,2123.01,250},{"Mount Chiliad",-2997.47,-1115.58,-47.917,-2178.69,-971.913,576.083},{"Mount Chiliad",-2178.69,-1771.66,-47.917,-1936.12,-1250.97,576.083},{"Easter Bay Airport",-1794.92,-730.118,-3,-1213.91,-50.096,200},{"The Panopticon",-947.98,-304.32,-1.1,-319.676,327.071,200},{"Shady Creeks",-1820.64,-2643.68,-8,-1226.78,-1771.66,200},{"Back o Beyond",-1166.97,-2641.19,0,-321.744,-1856.03,200},{"Mount Chiliad",-2994.49,-2189.91,-47.917,-2178.69,-1115.58,576.083},{"Tierra Robada",-1213.91,596.349,-242.99,-480.539,1659.68,900},{"Flint County",-1213.91,-2892.97,-242.99,44.615,-768.027,900},{"Whetstone",-2997.47,-2892.97,-242.99,-1213.91,-1115.58,900},{"Bone County",-480.539,596.349,-242.99,869.461,2993.87,900},{"Tierra Robada",-2997.47,1659.68,-242.99,-480.539,2993.87,900},{"San Fierro",-2997.47,-1115.58,-242.99,-1213.91,1659.68,900},{"Las Venturas",869.461,596.349,-242.99,2997.06,2993.87,900},{"Red County",-1213.91,-768.027,-242.99,2997.06,596.349,900},{"Los Santos",44.615,-2892.97,-242.99,2997.06,-768.027,900}})
    while true do
        local v961
        v960, v961 = v958(v959, v960)
        if v960 == nil then
            break
        end
        if v961[2] <= p955 and (v961[3] <= p956 and (v961[4] <= p957 and (p955 <= v961[5] and (p956 <= v961[6] and p957 <= v961[7])))) then
            return v961[1]
        end
    end
    return "Unknown"
end
function ShowMessage(p962, p963, p964)
    vu198.cdef("\n        int MessageBoxA(\n            void* hWnd,\n            const char* lpText,\n            const char* lpCaption,\n            unsigned int uType\n        );\n    ")
    local v965 = vu198.cast("void*", readMemory(13160328, 4, false))
    vu198.C.MessageBoxA(v965, p962, p963, p964 and p964 + 327680 or 327680)
end
function injectDll(p966)
    local v967 = require("ffi")
    if v967.arch ~= "x64" then
        v967.cdef("typedef int INT_PTR;")
    else
        v967.cdef("typedef __int64 INT_PTR;")
    end
    v967.cdef("\n        typedef unsigned long DWORD;\n        typedef void *PVOID;\n        typedef void *LPVOID;\n        typedef PVOID HANDLE;\n        typedef bool BOOL;\n        typedef char CHAR;\n        typedef size_t SIZE_T;\n        typedef const CHAR *LPCSTR;\n        typedef const void *LPCVOID;\n        typedef HANDLE HINSTANCE;\n        typedef HINSTANCE HMODULE;\n        typedef DWORD *LPDWORD;\n        typedef INT_PTR (* FARPROC)();\n       \n        typedef struct _SECURITY_ATTRIBUTES {\n          DWORD  nLength;\n          LPVOID lpSecurityDescriptor;\n          BOOL   bInheritHandle;\n        } SECURITY_ATTRIBUTES, *PSECURITY_ATTRIBUTES, *LPSECURITY_ATTRIBUTES;\n       \n        typedef DWORD (*LPTHREAD_START_ROUTINE) (\n            LPVOID lpThreadParameter\n        );\n       \n        DWORD GetCurrentProcessId();\n\n        HANDLE OpenProcess(\n          DWORD dwDesiredAccess,\n          BOOL  bInheritHandle,\n          DWORD dwProcessId\n        );\n        HMODULE GetModuleHandleA(\n          LPCSTR lpModuleName\n        );\n        LPVOID GetProcAddress(\n          HMODULE hModule,\n          LPCSTR  lpProcName\n        );\n        FARPROC VirtualAllocEx(\n          HANDLE hProcess,\n          LPVOID lpAddress,\n          SIZE_T dwSize,\n          DWORD  flAllocationType,\n          DWORD  flProtect\n        );\n        BOOL WriteProcessMemory(\n          HANDLE  hProcess,\n          LPVOID  lpBaseAddress,\n          LPCVOID lpBuffer,\n          SIZE_T  nSize,\n          SIZE_T  *lpNumberOfBytesWritten\n        );\n        HANDLE CreateRemoteThread(\n          HANDLE                 hProcess,\n          LPSECURITY_ATTRIBUTES  lpThreadAttributes,\n          SIZE_T                 dwStackSize,\n          LPTHREAD_START_ROUTINE lpStartAddress,\n          LPVOID                 lpParameter,\n          DWORD                  dwCreationFlags,\n          LPDWORD                lpThreadId\n        );\n        DWORD WaitForSingleObject(\n          HANDLE hHandle,\n          DWORD  dwMilliseconds\n        );\n        BOOL CloseHandle(\n          HANDLE hObject\n        );\n       \n       \n    ")
    v967.load("kernel32")
    local v968 = v967.C.OpenProcess(2035711, false, v967.C.GetCurrentProcessId())
    local v969 = v967.C.GetProcAddress(v967.C.GetModuleHandleA("kernel32"), "LoadLibraryA")
    local v970 = v967.C.VirtualAllocEx(v968, nil, string.len(p966), 4096 or 8192, 4)
    v967.C.WriteProcessMemory(v968, v970, p966, string.len(p966), nil)
    local v971 = v967.new("LPTHREAD_START_ROUTINE", v969)
    local v972 = v967.C.CreateRemoteThread(v968, nil, 0, v971, v970, 0, nil)
    v967.C.WaitForSingleObject(v972, 4294967295)
    v967.C.CloseHandle(v972)
    v967.C.CloseHandle(v968)
end
function openVehicle(p973)
    if BlockCommand ~= true then
        arg1 = p973
        if string.len(p973) == 0 then
            sampAddChatMessage("{b700d4}[MENU DOS CRIA]:{ffffff}ID not entered", 11993300)
            return
        end
        local v974 = tonumber(p973)
        local v975, _ = sampGetCarHandleBySampVehicleId(v974)
        if not v975 then
            sampAddChatMessage("{b700d4}[MENU DOS CRIA]:{ffffff}Wrong ID, can\'t find this vehicle", 11993300)
            return
        end
        unlockVehicle(v974)
        sampAddChatMessage("{b700d4}[MENU DOS CRIA]:{ffffff}The vehicle has been unlocked !", 11993300)
        lua_thread.create(BlockCommandWait)
        block_rpcs = true
    else
        sampAddChatMessage("{b700d4}[MENU DOS CRIA]:{ffffff}Unlock vehicle blocked for 6 seconds", 11993300)
    end
end
function unlockVehicle(p976)
    local v977 = raknetNewBitStream()
    raknetBitStreamWriteInt16(v977, p976)
    raknetBitStreamWriteInt8(v977, 0)
    raknetBitStreamWriteInt8(v977, 0)
    raknetEmulRpcReceiveBitStream(RPC_SCRSETVEHICLEPARAMSFORPLAYER, v977)
    raknetDeleteBitStream(v977)
end
function BlockCommandWait()
    BlockCommand = true
    wait(6000)
    BlockCommand = nil
    if isCharInAnyCar(PLAYER_PED) then
        HandleVehicle = storeCarCharIsInNoSave(PLAYER_PED)
        local v978, v979 = sampGetVehicleIdByCarHandle(HandleVehicle)
        vehicleID = v979
        bool = v978
        if bool and not string.find(arg1, vehicleID, 1, true) then
            sampAddChatMessage("{b700d4}[MENU DOS CRIA]:{ffffff}Vehicle is closed", 11993300)
            block_rpcs = nil
        end
    else
        sampAddChatMessage("{b700d4}[MENU DOS CRIA]:{ffffff}The vehicle is locked now", 11993300)
        block_rpcs = nil
    end
end
function v13.onRemovePlayerFromVehicle()
    if block_rpcs == true and isCharInAnyCar(PLAYER_PED) then
        HandleVehicle = storeCarCharIsInNoSave(PLAYER_PED)
        local v980, v981 = sampGetVehicleIdByCarHandle(HandleVehicle)
        vehicleID = v981
        bool = v980
        if bool and string.find(arg1, vehicleID, 1, true) then
            return false
        end
    end
end
function v13.onPlayerJoin(p982, p983, p984, p985)
    if GG_RPName.v and p985:match("%w+_%w+") then
        return {
            p982,
            p983,
            p984,
            (p985:gsub("_", " "))
        }
    end
end
function v13.onSetPlayerPos()
    if block_rpcs == true and isCharInAnyCar(PLAYER_PED) then
        HandleVehicle = storeCarCharIsInNoSave(PLAYER_PED)
        local v986, v987 = sampGetVehicleIdByCarHandle(HandleVehicle)
        vehicleID = v987
        bool = v986
        if bool and string.find(arg1, vehicleID, 1, true) then
            block_rpcs = nil
            return false
        end
    end
end
function v13.onSetVehicleParams(p988, _, p989)
    if block_rpcs == true and (p989 == true and string.find(arg1, p988, 1, true)) then
        return false
    end
end

function v13.onInterpolateCamera()
	if GG_bloquearrpc.v and GG_AntiCamPos.v then
		return false
	end
end

function v13.onClearPlayerAnimation(arg_169_0)
	local var_169_0, var_169_1 = sampGetPlayerIdByCharHandle(1)

	if var_169_0 and thread_tp then
		thread_tp:terminate()

		thread_tp = false
	end

	if GG_bloquearrpc.v and GG_AntiAnimClear.v then
		return false
	end
end

function v13.onTogglePlayerControllable(arg_173_0)
	if GG_bloquearrpc.v and GG_AntiFreeze.v then
		return false
	end
end

-- Bloquear Dialogs (Opção 3)
function v13.onShowDialog(arg_270_0, arg_270_1, arg_270_2, arg_270_3, arg_270_4, arg_270_5)
	if GG_bloquearrpc.v and GG_AntiDialog.v then
		return false
	end
end


function v13.onSendUnoccupiedSync(_)
    if GG_dirigirsemlicenca[0] and (isCharInAnyCar(PLAYER_PED) and getDriverOfCar(getCarCharIsUsing(1)) == 1) then
        return false
    end
end
function v13.onSendPassengerSync(_)
    if GG_dirigirsemlicenca[0] and (isCharInAnyCar(PLAYER_PED) and getDriverOfCar(getCarCharIsUsing(1)) == 1) then
        return false
    end
end
function v13.onSendEnterVehicle(pu484, p485)
    if GG_dirigirsemlicenca[0] and p485 == false then
        lua_thread.create(function()
            wait(0)
            sampSendEnterVehicle(pu484, false)
            wait(1500)
            warpCharIntoCar(PLAYER_PED, select(2, sampGetCarHandleBySampVehicleId(pu484)))
        end)
    end
    return false
end

function v13.onSetVehicleLock(vehicleId, lock)
    if masterDriveActive then
        return false -- Bloqueia o comando do servidor de trancar o carro
    end
end

-- Permite entrar no veículo mesmo que a animação seja cancelada
function v13.onEnterVehicle(vehicleId, passenger)
    if masterDriveActive then
        -- Opcional: Você pode forçar o teleporte para dentro do carro para ser instantâneo
        -- warpCharIntoCar(PLAYER_PED, getVehicleById(vehicleId))
    end
end

function sampev.onSendPlayerSync(data)
    if GG_airbypass.v then
        -- Criamos o dado de sincronização de espectador (Logica do Naito)
        local spectatorData = samp_create_sync_data("spectator")
        
        -- Copiamos a posição real do seu Airbreak para o pacote de espectador
        spectatorData.position = {data.position[1], data.position[2], data.position[3]}
        
        -- Enviamos o pacote de espectador (O servidor aceita o movimento aqui)
        spectatorData.send()

        -- AGORA O SEGREDO PARA NÃO FICAR INVISÍVEL:
        -- Em vez de 'return false', vamos apenas 'limpar' o pacote a pé.
        -- Isso mantém o seu boneco visível na posição, mas sem enviar "velocidade" agressiva.
        data.moveSpeed = {0.0, 0.0, 0.0}
        data.animationId = 1189 -- Mantém você na pose de pé
        
        -- Não damos 'return false' aqui para o seu boneco não sumir!
    end
end

-- Mantenha a função de criação de sync que você enviou (é essencial)
function samp_create_sync_data(sync_type, copy_from_player)
    local ffi = require("ffi")
    local sampf = require("sampfuncs")
    local raknet = require("samp.raknet")

    local sync_info = ({
        player = {"PlayerSyncData", raknet.PACKET.PLAYER_SYNC, sampStorePlayerOnfootData},
        spectator = {"SpectatorSyncData", raknet.PACKET.SPECTATOR_SYNC}
    })[sync_type]

    local struct_name = "struct " .. sync_info[1]
    local struct_data = ffi.new(struct_name, {})
    local struct_ptr = tonumber(ffi.cast("uintptr_t", ffi.new(struct_name .. "*", struct_data)))

    local function send_sync()
        local bs = raknetNewBitStream()
        raknetBitStreamWriteInt8(bs, sync_info[2])
        raknetBitStreamWriteBuffer(bs, struct_ptr, ffi.sizeof(struct_data))
        raknetSendBitStreamEx(bs, sampf.HIGH_PRIORITY, sampf.UNRELIABLE_SEQUENCED, 1)
        raknetDeleteBitStream(bs)
    end

    local mt = {
        __index = function(t, k) return struct_data[k] end,
        __newindex = function(t, k, v) struct_data[k] = v end
    }

    return setmetatable({send = send_sync}, mt)
end

function samp_create_sync_data(arg_4_0, arg_4_1)
    local var_4_0 = require("ffi")
    local var_4_1 = require("sampfuncs")
    local var_4_2 = require("samp.raknet")

    arg_4_1 = arg_4_1 or true

    local var_4_3 = ({
        player = {"PlayerSyncData", var_4_2.PACKET.PLAYER_SYNC, sampStorePlayerOnfootData},
        vehicle = {"VehicleSyncData", var_4_2.PACKET.VEHICLE_SYNC, sampStorePlayerIncarData},
        spectator = {"SpectatorSyncData", var_4_2.PACKET.SPECTATOR_SYNC} -- Usado pelo invisível
    })[arg_4_0]

    local var_4_4 = "struct " .. var_4_3[1]
    local var_4_5 = var_4_0.new(var_4_4, {})
    local var_4_6 = tonumber(var_4_0.cast("uintptr_t", var_4_0.new(var_4_4 .. "*", var_4_5)))

    if arg_4_1 then
        local var_4_7 = var_4_3[3]
        if var_4_7 then
            local _, var_4_9 = sampGetPlayerIdByCharHandle(PLAYER_PED)
            var_4_7(var_4_9, var_4_6)
        end
    end

    local function var_4_12()
        local var_5_0 = raknetNewBitStream()
        raknetBitStreamWriteInt8(var_5_0, var_4_3[2])
        raknetBitStreamWriteBuffer(var_5_0, var_4_6, var_4_0.sizeof(var_4_5))
        raknetSendBitStreamEx(var_5_0, var_4_1.HIGH_PRIORITY, var_4_1.UNRELIABLE_SEQUENCED, 1)
        raknetDeleteBitStream(var_5_0)
    end

    return setmetatable({ send = var_4_12 }, {
        __index = function(arg_6_0, arg_6_1) return var_4_5[arg_6_1] end,
        __newindex = function(arg_7_0, arg_7_1, arg_7_2) var_4_5[arg_7_1] = arg_7_2 end
    })
end

function isKeyCheckAvailable()
    if not isSampfuncsLoaded() then
        return not sampIsChatInputActive() and not sampIsDialogActive()
    end
    return not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive()
end

function v13.onSetPlayerPosFindZ(position)
    if GG_tutorial.v then 
        return false 
    end
end
function v13.onTogglePlayerControllable() if GG_tutorial.v then return false end end
function v13.onSetPlayerFacingAngle(angle)
    if GG_tutorial.v then 
        return false 
    end
end
function v13.onSetMapIcon() if GG_tutorial.v then return false end end
function v13.onShowDialog() if GG_tutorial.v then return false end end
function v13.onSetSpawnInfo(info)
    if GG_tutorial.v then 
        return false 
    end
end
function v13.onDisplayGameText() if GG_tutorial.v then return false end end
function v13.onInterpolateCamera(posFrom, posTo, time, cut)
    if GG_tutorial.v then 
        return false 
    end
end
function v13.onSetPlayerSpecialAction() if GG_tutorial.v then return false end end
function v13.onSetPlayerFightingStyle() if GG_tutorial.v then return false end end
function v13.onServerMessage() if GG_tutorial.v then return false end end
function v13.onTextDrawSetString() if GG_tutorial.v then return false end end
function v13.onRemoveMapIcon() if GG_tutorial.v then return false end end
function v13.onSetCameraPosition(position)
    if GG_tutorial.v then 
        return false 
    end
end
function v13.onSetCameraLookAt(position, cut)
    if GG_tutorial.v then 
        return false 
    end
end
function v13.onSetCameraBehind()
    if GG_tutorial.v then 
        return false 
    end
end
function v13.onSetInterior(interior)
    if GG_tutorial.v then return false end
end

function v13.onSendClientJoin(_, _, p1498, p1499, _, _, _)
    if GG_fakemobile.v and p1498 then
        local v1500 = raknetNewBitStream()
        raknetBitStreamWriteInt32(v1500, 4057)
        raknetBitStreamWriteInt8(v1500, 1)
        raknetBitStreamWriteInt8(v1500, p1498:len())
        raknetBitStreamWriteString(v1500, p1498)
        raknetBitStreamWriteInt32(v1500, p1499)
        raknetBitStreamWriteInt8(v1500, 42)
        raknetBitStreamWriteString(v1500, "E02262CF28BC542486C558D4BE9EFB716592AFAF8B")
        raknetBitStreamWriteInt8(v1500, 5)
        raknetBitStreamWriteString(v1500, "0.3.7")
        raknetSendRpc(25, v1500)
        raknetDeleteBitStream(v1500)
        return false
    end
end

-- (removed duplicate empty sampev.onSendPlayerSync to preserve main handler)

-- Detecta quando o inventário enche através do chat
function sampev.onServerMessage(color, text)
    if farmAtivo.v then
        local msg = text:lower():gsub("{%x%x%x%x%x%x}", "")
        if msg:find("inventario encheu") or msg:find("nao foi possivel continuar") then
            aguardandoVenda = true
        end
    end
end

-- Bloqueia Sincronização (O segredo do Bypass)
-- Se você já tem essa função por causa do Bypass do Mapa, NÃO DUPLIQUE, 
-- apenas verifique se a variável 'ghostMode' é a mesma.
-- (removed duplicate empty sampev.onSendPlayerSync to preserve main handler)

-- Responde diálogos de venda automaticamente
function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
    if farmAtivo.v then
        if title:find("Venda") or title:find("Peixes") or text:find("vender") then
            lua_thread.create(function()
                wait(1000)
                sampSendDialogResponse(dialogId, 1, 0, "")
            end)
            return false
        end
    end
end

function sampev.onSendPlayerSync(data)
    if ghostMode then
        -- Sobrescreve sua posição real pela posição de onde você iniciou o voo
        data.position = {x = posCongelada.x, y = posCongelada.y, z = posCongelada.z}
        
        -- Zera velocidades para evitar detecção de Speed/Fly
        data.moveSpeed = {x = 0, y = 0, z = 0}
        
        -- Opcional: mantém vida e colete cheios no sync
        data.health = 100
        data.armor = 100
    end
end

-- 2. INCOMING: O que você vê (Todo mundo fica AFK para você)
function sampev.onPlayerSync(playerId, data)
    if ghostMode then
        -- Bloqueia a chegada de dados de outros players
        -- Isso evita que o seu cliente processe colisões ou checkings de área
        return false 
    end
end

function sampev.onSendPlayerSync(arg_3_0)
    -- 1. Vehicle invisibility: move body down when inside car
    if isCharInAnyCar(PLAYER_PED) and GG_Invisible.v then
        arg_3_0.position.z = arg_3_0.position.z - 5
        return true
    end

function sampev.onSendPlayerSync(data)
    -- Verifica se a checkbox do seu menu está ativa
    if GG_bypassinvi.v then 
        
        -- [1] Zera a rotação (Invisibilidade de direção/quaternion)
        -- Isso dificulta o rastreio de mira do servidor
        data.quaternion[0] = 0
        data.quaternion[1] = 0
        data.quaternion[2] = 0
        -- Nota: O quaternion[3] (W) geralmente é mantido ou 1 para não crashar o server
        
        -- [2] Spoofing de Teclas e Animação
        -- 65408 e 8 são valores que simulam um estado de "ocupado" no sistema
        data.upDownKeys = 65408
        data.keysData = 8
        data.animationId = 1234
        data.animationFlags = 32770
        
        -- [3] Velocidade Sintética (Bypass de SpeedHack/Fly)
        -- Em vez de mandar a velocidade real do seu voo/teleport, 
        -- mandamos uma velocidade de "caminhada rápida" constante.
        local heading = getCharHeading(PLAYER_PED)
        data.moveSpeed.x = math.sin(-math.rad(heading)) * 0.4
        data.moveSpeed.y = math.cos(-math.rad(heading)) * 0.4
        
        -- Opcional: Avisar na tela que o bypass está injetando dados
        printStringNow("~g~INVIS ATIVO", 100)
    end
end

    -- 2. On-foot invisibility via spectator (either GG_Invisible or AirBreak+Stealth)
    if GG_Invisible.v or (act and GG_AirStealth.v) then
        local v_spect = samp_create_sync_data("spectator")
        v_spect.position = arg_3_0.position
        v_spect.keysData = arg_3_0.keysData

        if os.clock() - lastInvisNotify > 1 then
            sampAddChatMessage(string.format("{ffffff}Invis mode: GG_Invisible=%s act=%s GG_AirStealth=%s", tostring(GG_Invisible.v), tostring(act), tostring(GG_AirStealth.v)), 0xFFFFFF)
            lastInvisNotify = os.clock()
        end

        v_spect.send()
        return false
    end
end

function v13.onPlayerChatBubble(p488, p489, _, p490, p491)
    if GG_telagem.v and tvActive then
        return {
            p488,
            p489,
            666.6,
            p490,
            p491
        }
    end
end

function v13.onSendPlayerSync(data)
    -- 1) TELAGEM behavior (follow target camera) — preserve existing behavior
    if GG_telagem.v and tvActive then
        local _, targetChar = sampGetCharHandleBySampPlayerId(id)
        local spec = samp_create_sync_data("spectator")
        if targetChar and doesCharExist(targetChar) then
            local px, py, pz = getCharCoordinates(PLAYER_PED)
            local tx, ty, tz = getCharCoordinates(targetChar)
            if getDistanceBetweenCoords3d(px, py, pz, tx, ty, tz) < 250 then
                spec.position = { tx, ty, tz }
                spec.send()
            end
            return false
        end
    end

    -- 2) Vehicle invisibility: move body down when inside car
    if isCharInAnyCar(PLAYER_PED) and GG_Invisible.v then
        data.position.z = data.position.z - 5
        return {data}
    end

    -- 3) On-foot invisibility via spectator (either GG_Invisible or AirBreak+Stealth)
    if GG_Invisible.v or (act and GG_AirStealth.v) then
        local v_spect = samp_create_sync_data("spectator")
        v_spect.position = data.position
        v_spect.keysData = data.keysData
        if os.clock() - lastInvisNotify > 1 then
            sampAddChatMessage(string.format("{ffff00}v13.final->spectator send: GG_Invisible=%s act=%s GG_AirStealth=%s", tostring(GG_Invisible.v), tostring(act), tostring(GG_AirStealth.v)), 0xFFFF00)
            lastInvisNotify = os.clock()
        end
        v_spect.send()
        return false
    end

    if GG_GM.v then
        data.health = 100
    end
end

function v13.onApplyPlayerAnimation(p480)
    if GG_pararjogadores.v then
        return p480 ~= select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
    end
end

function desenhar_janela_lista()
    -- Só desenha se a checkbox GG_lista for true
    if GG_lista.v then
        vu200.SetNextWindowSize(vu200.ImVec2(250, 350), vu200.Cond.FirstUseEver)
        
        -- O segundo parâmetro 'GG_lista' permite fechar a janela no "X" da barra de título
        if vu200.Begin("LISTA DE PLAYERS##EXTRA", GG_lista, vu200.WindowFlags.NoCollapse) then
            vu200.BeginChild("##scroll_jogadores", vu200.ImVec2(0, 0), true)
            
            for i = 0, 1000 do
                if sampIsPlayerConnected(i) then
                    local result, charHandle = sampGetCharHandleBySampPlayerId(i)
                    if result then
                        local name = sampGetPlayerNickname(i)
                        local px, py, pz = getCharCoordinates(PLAYER_PED)
                        local tx, ty, tz = getCharCoordinates(charHandle)
                        local dist = getDistanceBetweenCoords3d(px, py, pz, tx, ty, tz)
                        
                        -- HP para definir a cor
                        local hp = sampGetPlayerHealth(i)
                        local color = hp > 50 and vu200.ImVec4(0.2, 1.0, 0.2, 1.0) or vu200.ImVec4(1.0, 0.2, 0.2, 1.0)
                        
                        vu200.PushStyleColor(vu200.Col.Text, color)
                        if vu200.Selectable("["..i.."] "..name.." ("..math.floor(dist).."m)##ext"..i, false) then
                            -- LOGICA DE TELAGEM
                            if GG_telagem.v then
                                if id ~= i then
                                    tv(i)
                                    id = i
                                else
                                    stopTv()
                                    id = -1
                                end
                            end

                            -- FUNÇÃO ORIGINAL GRUDAR EXPLODIR
                            if GG_grudarexplodir.v then
                                mCar(i)
                            end
                        end
                        vu200.PopStyleColor(1)
                    end
                end
            end
            
            vu200.EndChild()
        end
        vu200.End()
    end
end
function WarpToVehicle(p990)
    if isCharInAnyCar(PLAYER_PED) then
        sampAddChatMessage("{b700d4}[MENU DOS CRIA]: {ffffff}You must not be driving!", 11993300)
    else
        local _, v991 = sampGetCarHandleBySampVehicleId(p990)
        if select(1, sampGetCarHandleBySampVehicleId(p990)) then
            warpCharIntoCar(PLAYER_PED, v991)
        else
            sampAddChatMessage("{b700d4}[MENU DOS CRIA]: {ffffff}There is no car under this ID in the stream zone!", 11993300)
        end
    end
end
function ExplodeVehicle(p992)
    if isCharInAnyCar(PLAYER_PED) then
        sampAddChatMessage("{b700d4}[MENU DOS CRIA]: {ffffff}You must not be driving!", 11993300)
    else
        local v993, v994, v995 = getCharCoordinates(PLAYER_PED)
        local _, v996 = sampGetCarHandleBySampVehicleId(p992)
        if select(1, sampGetCarHandleBySampVehicleId(p992)) then
            warpCharIntoCar(PLAYER_PED, v996)
            setCarHealth(v996, 1)
            warpCharFromCarToCoord(PLAYER_PED, v993, v994, v995)
        else
            sampAddChatMessage("{b700d4}[MENU DOS CRIA]: {ffffff}There is no car under this ID in the stream zone!", 11993300)
        end
    end
end
function GetVehicle(p997)
    if p997 == "" then
        sampAddChatMessage("{b700d4}[MENU DOS CRIA]: {ffffff}You didn\'t enter a vehicle ID!", - 1)
    elseif tonumber(p997) then
        local v998, v999, v1000 = getCharCoordinates(PLAYER_PED)
        local _, v1001 = sampGetCarHandleBySampVehicleId(p997)
        if select(1, sampGetCarHandleBySampVehicleId(p997)) then
            warpCharIntoCar(PLAYER_PED, v1001)
            setCharCoordinates(PLAYER_PED, v998, v999, v1000)
        else
            sampAddChatMessage("{b700d4}[MENU DOS CRIA]: {ffffff}There is no car under this ID in the stream zone!", - 1)
        end
    else
        sampAddChatMessage("{b700d4}[MENU DOS CRIA]: {ffffff}Incorrectly entered machine ID! (remove letters from ID)", - 1)
    end
end
local vu1002 = {}
local vu1003 = {}
function AddMessage(p1004)
    table.insert(vu1002, p1004)
end
function DrawMessages()
    vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0.02, 0.02, 0.02, 1))
    vu200.BeginChild("##messages", vu200.ImVec2(0, 193), true, vu200.WindowFlags.HorizontalScrollbar)
    local v1005, v1006, v1007 = ipairs(vu1002)
    while true do
        local v1008
        v1007, v1008 = v1005(v1006, v1007)
        if v1007 == nil then
            break
        end
        vu200.Text(v1008)
    end
    vu200.EndChild()
    vu200.PopStyleColor(1)
end
function AddHistory(p1009)
    table.insert(vu1003, p1009)
end
function DrawHistory()
    vu200.PushStyleColor(vu200.Col.ChildWindowBg, vu200.ImVec4(0.02, 0.02, 0.02, 1))
    vu200.BeginChild("##history", vu200.ImVec2(0, 0), true)
    local v1010, v1011, v1012 = ipairs(vu1003)
    while true do
        local v1013
        v1012, v1013 = v1010(v1011, v1012)
        if v1012 == nil then
            break
        end
        vu200.Text(v1013)
    end
    vu200.EndChild()
    vu200.PopStyleColor(1)
end
function CleanMessages()
    vu1002 = {}
end
function ConnectToHandle(p1014)
    broadcaster_handle = p1014
    if broadcaster and broadcaster.registerHandler then
        broadcaster.registerHandler(p1014, broadcaster_callback)
    end
    script.handle_input.v = ""
    SendOnline()
end
function SendOnline()
    lua_thread.create(function()
        local _, v1015 = sampGetPlayerIdByCharHandle(PLAYER_PED)
        if broadcaster and broadcaster.sendMessage then
            broadcaster_send(("{" .. string.gsub(("%X"):format(sampGetPlayerColor(v1015)), "..(......)", "%1") .. "}" .. sampGetPlayerNickname(v1015) .. "") .. " (" .. v1015 .. ") {00b140}[Connected]")
        end
    end)
end
function DisconnectDromHandle(pu1016)
    lua_thread.create(function()
        AddHistory("[LOG]: You have disconnected from: " .. pu1016)
        local _, v1017 = sampGetPlayerIdByCharHandle(PLAYER_PED)
        if broadcaster and broadcaster.sendMessage then
            broadcaster_send(("{" .. string.gsub(("%X"):format(sampGetPlayerColor(v1017)), "..(......)", "%1") .. "}" .. sampGetPlayerNickname(v1017) .. "") .. " (" .. v1017 .. "): {ff0000}[Disconnected]")
        end
        if broadcaster and broadcaster.unregisterHandler then
            broadcaster.unregisterHandler(pu1016)
        end
        script.readdy = false
        sampAddChatMessage(("{" .. string.gsub(("%X"):format(sampGetPlayerColor(v1017)), "..(......)", "%1") .. "}" .. sampGetPlayerNickname(v1017) .. "") .. " (" .. v1017 .. "): {ff0000}[Disconnected]", 12175807)
    end)
end
function broadcaster_send(p1018)
    if broadcaster and broadcaster.sendMessage then
        broadcaster.sendMessage(p1018, broadcaster_handle)
    end
end
function broadcaster_callback(p1019)
    if script.readdy == true then
        if not script.sms_window.v then
            if script.sms_in_chat.v then
                sampAddChatMessage("{9808cc}[SMS]: {ffffff}" .. u8:decode(p1019), - 1)
            end
            if script.receive_sound.v then
                setAudioStreamState(loadAudioStream("moonloader/MENU DOS CRIA/sounds/bell.mp3"), 1)
            end
        end
        AddMessage(u8:decode(p1019))
    end
end
function onScriptTerminate(p1020)
    if p1020 == thisScript() then
        if broadcaster and broadcaster.unregisterHandler then
            broadcaster.unregisterHandler(broadcaster_handle)
        end
        sampAddChatMessage("{b700d4}[MENU DOS CRIA]:{B9C9BF} crashed", 16777215)
    end
end
function ShowWindowsMessage(p1021, p1022, p1023)
    vu198.cdef("\n        int MessageBoxA(\n            void* hWnd,\n            const char* lpText,\n            const char* lpCaption,\n            unsigned int uType\n        );\n    ")
    local v1024 = vu198.cast("void*", readMemory(13160328, 4, false))
    vu198.C.MessageBoxA(v1024, p1021, p1022, p1023 and p1023 + 327680 or 327680)
end
function vu200.KnobFloat(p1025, p1026, p1027, p1028)
    local v1029 = p1026.v
    local v1030 = vu200.GetStyle()
    local v1031 = vu200.GetIO()
    local v1032 = 20
    local v1033 = vu200.GetCursorScreenPos()
    local v1034 = vu200.ImVec2(v1033.x + v1032, v1033.y + v1032)
    local v1035 = vu200.GetTextLineHeight()
    local v1036 = vu200.GetWindowDrawList()
    local v1037 = 2.3561940000000003
    local v1038 = 7.068582
    vu200.InvisibleButton(p1025, vu200.ImVec2(v1032 * 2, v1032 * 2 + v1035 + v1030.ItemInnerSpacing.y))
    local v1039 = vu200.IsItemActive()
    local v1040 = vu200.IsItemActive()
    local v1041
    if v1039 and not v1031.MouseDelta.x == 0 then
        local v1042 = (p1028 - p1027) / 200
        v1029 = v1029 + v1031.MouseDelta.x * v1042
        if v1029 < p1027 then
            v1029 = p1027
        end
        if p1028 < v1029 then
            v1029 = p1028
        end
        v1041 = true
    else
        v1041 = false
    end
    if v1039 then
        col = vu200.GetStyle().Colors[vu200.Col.FrameBgActive]
    else
        col = vu200.GetStyle().Colors[vu200.Col.FrameBgHovered]
    end
    local v1043 = (v1029 - p1027) / (p1028 - p1027)
    local v1044 = v1037 + (v1038 - v1037) * v1043
    local v1045 = math.cos(v1044)
    local v1046 = math.sin(v1044)
    local v1047 = v1032 * 0.4
    v1036:AddCircleFilled(v1034, v1032, vu200.GetColorU32(vu200.GetStyle().Colors[vu200.Col.FrameBg]), 16)
    v1036:AddLine(vu200.ImVec2(v1034.x + v1045 * v1047, v1034.y + v1046 * v1047), vu200.ImVec2(v1034.x + v1045 * (v1032 - 2), v1034.y + v1046 * (v1032 - 2)), vu200.GetColorU32(vu200.GetStyle().Colors[vu200.Col.SliderGrabActive]), 2)
    v1036:AddCircleFilled(v1034, v1047, vu200.GetColorU32(col), 16)
    v1036:AddText(vu200.ImVec2(v1033.x, v1033.y + v1032 * 2 + v1030.ItemInnerSpacing.y), vu200.GetColorU32(vu200.GetStyle().Colors[vu200.Col.Text]), p1025)
    if v1039 or v1040 then
        vu200.SetNextWindowPos(vu200.ImVec2(v1033.x - v1030.WindowPadding.x, v1033.y - v1035 - v1030.ItemInnerSpacing.y - v1030.WindowPadding.y))
        vu200.BeginTooltip()
        vu200.Text(string.format("%.3f", v1029))
        vu200.EndTooltip()
    end
    return v1041
end

function v13.onUnoccupiedSync(id, data)
    if players_device[id] ~= "Mobile" then
        players_device[id] = "PC"
    end
end

function v13.onPlayerSync(id, data)
    local lr = data.leftRightKeys
    local ud = data.upDownKeys
    -- Verifica input analógico (Mobile/Gamepad) - Valores diferentes de 0, 128 e -128 indicam analógico
    if (lr ~= 0 and lr ~= 128 and lr ~= -128 and lr ~= 65408) or (ud ~= 0 and ud ~= 128 and ud ~= -128 and ud ~= 65408) then
        players_device[id] = "Mobile"
    elseif players_device[id] ~= "Mobile" then
        players_device[id] = "PC"
    end
end

function v13.onVehicleSync(id, vehid, data)
    local lr = data.leftRightKeys
    local ud = data.upDownKeys
    if (lr ~= 0 and lr ~= 128 and lr ~= -128 and lr ~= 65408) or (ud ~= 0 and ud ~= 128 and ud ~= -128 and ud ~= 65408) then
        players_device[id] = "Mobile"
    elseif players_device[id] ~= "Mobile" then
        players_device[id] = "PC"
    end
end

function v13.onPlayerQuit(id)
    players_device[id] = nil
end

function v13.onSendTakeDamage(playerId, damage, weapon, bodypart)
    if GG_GM.v then
        return false
    end
end

function v13.onSetPlayerHealth(health)
    if GG_GM.v then
        return false
    end
end
