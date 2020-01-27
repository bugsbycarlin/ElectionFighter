local bidenSpriteInfo = {}

bidenSpriteInfo.sheet =
{
    frames = {
    
        {
            x=0,
            y=0,
            width=256,
            height=256,

        },
        {
            x=256,
            y=0,
            width=256,
            height=256,

        },
        {
            x=512,
            y=0,
            width=256,
            height=256,

        },
        {
            x=768,
            y=0,
            width=256,
            height=256,

        },
        {
            x=1024,
            y=0,
            width=256,
            height=256,

        },
        {
            x=1280,
            y=0,
            width=256,
            height=256,

        },
        {
            x=1536,
            y=0,
            width=256,
            height=256,

        },
        {
            x=1792,
            y=0,
            width=256,
            height=256,

        },
        {
            x=0,
            y=256,
            width=256,
            height=256,

        },
        {
            x=256,
            y=256,
            width=256,
            height=256,

        },
        {
            x=512,
            y=256,
            width=256,
            height=256,

        },
        {
            x=768,
            y=256,
            width=256,
            height=256,

        },
        {
            x=1024,
            y=256,
            width=256,
            height=256,

        },
        {
            x=1280,
            y=256,
            width=256,
            height=256,

        },
        {
            x=1536,
            y=256,
            width=256,
            height=256,

        },
        {
            x=1792,
            y=256,
            width=256,
            height=256,

        },
        {
            x=0,
            y=512,
            width=256,
            height=256,

        },
        {
            x=256,
            y=512,
            width=256,
            height=256,

        },
        {
            x=512,
            y=512,
            width=256,
            height=256,

        },
        {
            x=768,
            y=512,
            width=256,
            height=256,

        },
    },

    sheetContentWidth = 2048,
    sheetContentHeight = 1024
}


-- 256, 512, 768, 1024, 1280, 1536, 1792, 2048, 2304, 2560, 2816, 3072, 3328, 3584, 3840, 4096, 4352, 4608, 4864


-- 384, 768, 1152, 1536, 1920, 2304, 2688, 3072, 3456, 3840, 4224, 4608, 4992, 5376, 5760, 6144, 6528, 6912, 729

bidenSpriteInfo.frameIndex =
{
    ["normal"] = 1,
    ["punch"] = 3,
    ["damage"] = 2,
}

bidenSpriteInfo.hitIndex = 
{
  {
    {x=39.666666666667,y=-42.333333333333,type="circle",purpose="defense",radius=11},
    {x=8.6666666666667,y=-70,type="circle",purpose="vulnerability",radius=24},
    {x=-1.3333333333333,y=-31,type="circle",purpose="vulnerability",radius=24},
    {x=20,y=-36.333333333333,type="circle",purpose="vulnerability",radius=11},
    {x=28.666666666667,y=-22.666666666667,type="circle",purpose="vulnerability",radius=12},
    {x=-3.6666666666667,y=-1,type="circle",purpose="vulnerability",radius=18},
    {x=14,y=13,type="circle",purpose="vulnerability",radius=15},
    {x=21.333333333333,y=29,type="circle",purpose="vulnerability",radius=15},
    {x=21,y=46.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=21,y=67,type="circle",purpose="vulnerability",radius=12},
    {x=33.333333333333,y=70,type="circle",purpose="vulnerability",radius=10},
    {x=-14,y=24,type="circle",purpose="vulnerability",radius=15},
    {x=-22.666666666667,y=46.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=-37,y=62.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=-42.666666666667,y=75.333333333333,type="circle",purpose="vulnerability",radius=15},
  },
  {
    {x=39.333333333333,y=-36.333333333333,type="circle",purpose="defense",radius=11},
    {x=8.3333333333333,y=-64.666666666667,type="circle",purpose="vulnerability",radius=24},
    {x=-3,y=-24.666666666667,type="circle",purpose="vulnerability",radius=24},
    {x=20,y=-31.333333333333,type="circle",purpose="vulnerability",radius=12},
    {x=28,y=-19,type="circle",purpose="vulnerability",radius=12},
    {x=-1.3333333333333,y=4.3333333333333,type="circle",purpose="vulnerability",radius=18},
    {x=-12.666666666667,y=29,type="circle",purpose="vulnerability",radius=15},
    {x=-20.333333333333,y=47.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=-37.333333333333,y=64,type="circle",purpose="vulnerability",radius=15},
    {x=-45.333333333333,y=76.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=15.333333333333,y=17.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=22,y=31.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=23.333333333333,y=47.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=26.666666666667,y=69.666666666667,type="circle",purpose="vulnerability",radius=15},
  },
  {
    {x=37.333333333333,y=-30,type="circle",purpose="defense",radius=11},
    {x=-3,y=-22,type="circle",purpose="vulnerability",radius=24},
    {x=18,y=-28.333333333333,type="circle",purpose="vulnerability",radius=12},
    {x=27.666666666667,y=-13.333333333333,type="circle",purpose="vulnerability",radius=12},
    {x=-4,y=5.3333333333333,type="circle",purpose="vulnerability",radius=18},
    {x=-12.666666666667,y=32.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=-21,y=48.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=-37.333333333333,y=64.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=-44.333333333333,y=74.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=15.333333333333,y=18,type="circle",purpose="vulnerability",radius=15},
    {x=24.333333333333,y=34.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=26,y=52.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=30,y=71.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=7.3333333333333,y=-62.333333333333,type="circle",purpose="vulnerability",radius=25},
  },
  {
    {x=8,y=-66.333333333333,type="circle",purpose="vulnerability",radius=23},
    {x=-2.3333333333333,y=-28.333333333333,type="circle",purpose="vulnerability",radius=24},
    {x=21.333333333333,y=-30.666666666667,type="circle",purpose="vulnerability",radius=12},
    {x=28.666666666667,y=-18,type="circle",purpose="vulnerability",radius=12},
    {x=-2.3333333333333,y=0.66666666666667,type="circle",purpose="vulnerability",radius=18},
    {x=-11.666666666667,y=24.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=-19.333333333333,y=45,type="circle",purpose="vulnerability",radius=15},
    {x=-35.333333333333,y=60.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=-42.666666666667,y=74.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=16,y=16,type="circle",purpose="vulnerability",radius=15},
    {x=24.666666666667,y=34,type="circle",purpose="vulnerability",radius=15},
    {x=24.666666666667,y=53.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=28,y=70.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=38.666666666667,y=-36.666666666667,type="circle",purpose="defense",radius=11},
  },
  {
    {x=25.666666666667,y=66.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=40,y=-41.333333333333,type="circle",purpose="defense",radius=11},
    {x=7,y=-69.333333333333,type="circle",purpose="vulnerability",radius=24},
    {x=-2.6666666666667,y=-30.333333333333,type="circle",purpose="vulnerability",radius=24},
    {x=19.666666666667,y=-37,type="circle",purpose="vulnerability",radius=12},
    {x=28.333333333333,y=-24.666666666667,type="circle",purpose="vulnerability",radius=12},
    {x=-3.6666666666667,y=-0.66666666666667,type="circle",purpose="vulnerability",radius=18},
    {x=-13.666666666667,y=25,type="circle",purpose="vulnerability",radius=15},
    {x=-22.333333333333,y=44,type="circle",purpose="vulnerability",radius=15},
    {x=-34,y=59,type="circle",purpose="vulnerability",radius=15},
    {x=-41.333333333333,y=74.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=13,y=12.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=19,y=26.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=21.666666666667,y=43.333333333333,type="circle",purpose="vulnerability",radius=15},
  },
  {
    {x=42,y=-41.333333333333,type="circle",purpose="defense",radius=11},
    {x=8,y=-68,type="circle",purpose="vulnerability",radius=23},
    {x=-0.33333333333333,y=-26.666666666667,type="circle",purpose="vulnerability",radius=24},
    {x=21.666666666667,y=-33,type="circle",purpose="vulnerability",radius=12},
    {x=32.666666666667,y=-23.333333333333,type="circle",purpose="vulnerability",radius=12},
    {x=-3,y=-0.33333333333333,type="circle",purpose="vulnerability",radius=18},
    {x=-12,y=25,type="circle",purpose="vulnerability",radius=15},
    {x=-19.666666666667,y=45,type="circle",purpose="vulnerability",radius=15},
    {x=-36,y=61.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=-42.666666666667,y=76.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=15,y=15,type="circle",purpose="vulnerability",radius=15},
    {x=22.666666666667,y=32,type="circle",purpose="vulnerability",radius=15},
    {x=23,y=50.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=26.666666666667,y=69.666666666667,type="circle",purpose="vulnerability",radius=15},
  },
  {
    {x=7,y=-64,type="circle",purpose="vulnerability",radius=23},
    {x=-0.66666666666667,y=-23,type="circle",purpose="vulnerability",radius=24},
    {x=24,y=-29.666666666667,type="circle",purpose="vulnerability",radius=12},
    {x=35.666666666667,y=-21.333333333333,type="circle",purpose="vulnerability",radius=12},
    {x=-2.3333333333333,y=6.3333333333333,type="circle",purpose="vulnerability",radius=18},
    {x=-10.666666666667,y=29,type="circle",purpose="vulnerability",radius=15},
    {x=-16.666666666667,y=49.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=-35.333333333333,y=61,type="circle",purpose="vulnerability",radius=15},
    {x=-44.666666666667,y=75.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=17.666666666667,y=20,type="circle",purpose="vulnerability",radius=15},
    {x=26.666666666667,y=36.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=28,y=56.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=29.666666666667,y=70.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=42,y=-42,type="circle",purpose="defense",radius=11},
  },
  {
    {x=45.666666666667,y=-48,type="circle",purpose="defense",radius=11},
    {x=7.6666666666667,y=-68,type="circle",purpose="vulnerability",radius=23},
    {x=-0.66666666666667,y=-28.333333333333,type="circle",purpose="vulnerability",radius=24},
    {x=28.666666666667,y=-33.666666666667,type="circle",purpose="vulnerability",radius=12},
    {x=39.333333333333,y=-28,type="circle",purpose="vulnerability",radius=12},
    {x=-3.3333333333333,y=1.6666666666667,type="circle",purpose="vulnerability",radius=18},
    {x=-12.666666666667,y=27,type="circle",purpose="vulnerability",radius=15},
    {x=-18,y=46,type="circle",purpose="vulnerability",radius=15},
    {x=-35.666666666667,y=61,type="circle",purpose="vulnerability",radius=15},
    {x=-42.666666666667,y=75,type="circle",purpose="vulnerability",radius=15},
    {x=16.666666666667,y=17.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=23.666666666667,y=34,type="circle",purpose="vulnerability",radius=15},
    {x=22.666666666667,y=54,type="circle",purpose="vulnerability",radius=15},
    {x=29,y=70.666666666667,type="circle",purpose="vulnerability",radius=15},
  },
  {
    {x=6.3333333333333,y=-69.666666666667,type="circle",purpose="vulnerability",radius=23},
    {x=-2,y=-30.333333333333,type="circle",purpose="vulnerability",radius=24},
    {x=28.666666666667,y=-36.666666666667,type="circle",purpose="vulnerability",radius=12},
    {x=41,y=-34.666666666667,type="circle",purpose="vulnerability",radius=12},
    {x=-2,y=0,type="circle",purpose="vulnerability",radius=18},
    {x=-14.666666666667,y=23,type="circle",purpose="vulnerability",radius=15},
    {x=-21,y=40.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=-32.666666666667,y=56,type="circle",purpose="vulnerability",radius=15},
    {x=-39.333333333333,y=71.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=15.666666666667,y=16.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=21.333333333333,y=32.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=20.333333333333,y=49.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=26,y=67.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=47,y=-53,type="circle",purpose="defense",radius=11},
  },
  {
    {x=8,y=-65.666666666667,type="circle",purpose="vulnerability",radius=23},
    {x=-0.66666666666667,y=-25.333333333333,type="circle",purpose="vulnerability",radius=24},
    {x=24,y=-31.333333333333,type="circle",purpose="vulnerability",radius=12},
    {x=34.666666666667,y=-23.333333333333,type="circle",purpose="vulnerability",radius=12},
    {x=-2.3333333333333,y=3.6666666666667,type="circle",purpose="vulnerability",radius=18},
    {x=-8.6666666666667,y=29.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=-13.333333333333,y=47,type="circle",purpose="vulnerability",radius=15},
    {x=-27.333333333333,y=63.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=-36,y=79.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=15,y=18.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=19.666666666667,y=36.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=17.666666666667,y=54.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=19,y=70.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=43.333333333333,y=-40.333333333333,type="circle",purpose="defense",radius=11},
  },
  {
    {x=36.666666666667,y=-32,type="circle",purpose="defense",radius=10},
    {x=8,y=-63.333333333333,type="circle",purpose="vulnerability",radius=23},
    {x=-1,y=-22,type="circle",purpose="vulnerability",radius=24},
    {x=18.333333333333,y=-27.333333333333,type="circle",purpose="vulnerability",radius=12},
    {x=26.666666666667,y=-16.666666666667,type="circle",purpose="vulnerability",radius=12},
    {x=-2,y=5.3333333333333,type="circle",purpose="vulnerability",radius=18},
    {x=7,y=25,type="circle",purpose="vulnerability",radius=21},
    {x=19,y=42,type="circle",purpose="vulnerability",radius=15},
    {x=-6.6666666666667,y=53.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=-19,y=69.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=-26,y=80,type="circle",purpose="vulnerability",radius=15},
    {x=15.333333333333,y=62.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=14,y=72,type="circle",purpose="vulnerability",radius=15},
  },
  {
    {x=26.666666666667,y=-35.333333333333,type="circle",purpose="defense",radius=15},
    {x=0.66666666666667,y=-25,type="circle",purpose="vulnerability",radius=24},
    {x=26,y=-20,type="circle",purpose="vulnerability",radius=12},
    {x=7.6666666666667,y=-65.666666666667,type="circle",purpose="vulnerability",radius=23},
    {x=0,y=8.6666666666667,type="circle",purpose="vulnerability",radius=18},
    {x=4.6666666666667,y=32,type="circle",purpose="vulnerability",radius=21},
    {x=-7.6666666666667,y=69.333333333333,type="circle",purpose="vulnerability",radius=21},
    {x=7,y=49.666666666667,type="circle",purpose="vulnerability",radius=12},
  },
  {
    {x=24,y=-44,type="circle",purpose="defense",radius=15},
    {x=8,y=-68.666666666667,type="circle",purpose="vulnerability",radius=24},
    {x=1.3333333333333,y=-27.333333333333,type="circle",purpose="vulnerability",radius=24},
    {x=28,y=-24,type="circle",purpose="vulnerability",radius=12},
    {x=-2.6666666666667,y=1.3333333333333,type="circle",purpose="vulnerability",radius=18},
    {x=0.66666666666667,y=23.333333333333,type="circle",purpose="vulnerability",radius=18},
    {x=-5.3333333333333,y=52,type="circle",purpose="vulnerability",radius=21},
    {x=-6.6666666666667,y=81,type="circle",purpose="vulnerability",radius=15},
  },
  {
    {x=-3.6666666666667,y=-25,type="circle",purpose="vulnerability",radius=23},
    {x=27.666666666667,y=-19,type="circle",purpose="vulnerability",radius=9},
    {x=0,y=7.3333333333333,type="circle",purpose="vulnerability",radius=18},
    {x=5.3333333333333,y=27,type="circle",purpose="vulnerability",radius=18},
    {x=0.33333333333333,y=51,type="circle",purpose="vulnerability",radius=18},
    {x=-9.3333333333333,y=74,type="circle",purpose="vulnerability",radius=18},
    {x=13,y=41.333333333333,type="circle",purpose="vulnerability",radius=12},
    {x=24.666666666667,y=-36.666666666667,type="circle",purpose="defense",radius=15},
    {x=8.3333333333333,y=-66.666666666667,type="circle",purpose="vulnerability",radius=23},
  },
  {
    {x=7,y=-62.666666666667,type="circle",purpose="vulnerability",radius=23},
    {x=0.33333333333333,y=-22,type="circle",purpose="vulnerability",radius=24},
    {x=24.666666666667,y=-16.666666666667,type="circle",purpose="vulnerability",radius=12},
    {x=-1,y=6.6666666666667,type="circle",purpose="vulnerability",radius=18},
    {x=7,y=30.333333333333,type="circle",purpose="vulnerability",radius=24},
    {x=16,y=51,type="circle",purpose="vulnerability",radius=15},
    {x=14.333333333333,y=72,type="circle",purpose="vulnerability",radius=15},
    {x=-14,y=59.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=-26.666666666667,y=80,type="circle",purpose="vulnerability",radius=15},
    {x=31,y=-33.666666666667,type="circle",purpose="defense",radius=11},
  },
  {
    {x=8,y=-65.333333333333,type="circle",purpose="vulnerability",radius=23},
    {x=0,y=-26.666666666667,type="circle",purpose="vulnerability",radius=24},
    {x=28.666666666667,y=-20,type="circle",purpose="vulnerability",radius=12},
    {x=0,y=4.6666666666667,type="circle",purpose="vulnerability",radius=18},
    {x=-7.3333333333333,y=30,type="circle",purpose="vulnerability",radius=15},
    {x=-15.333333333333,y=51.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=-30,y=68,type="circle",purpose="vulnerability",radius=15},
    {x=-33,y=77.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=17.333333333333,y=21.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=20.333333333333,y=40.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=17.666666666667,y=60,type="circle",purpose="vulnerability",radius=15},
    {x=20.666666666667,y=72,type="circle",purpose="vulnerability",radius=15},
    {x=35.333333333333,y=-37.333333333333,type="circle",purpose="defense",radius=11},
  },
  {
    {x=-6.3333333333333,y=-72.333333333333,type="circle",purpose="vulnerability",radius=24},
    {x=-12.333333333333,y=-29.333333333333,type="circle",purpose="vulnerability",radius=27},
    {x=19.333333333333,y=-36.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=-5,y=16,type="circle",purpose="vulnerability",radius=27},
    {x=19.333333333333,y=46.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=25,y=61,type="circle",purpose="vulnerability",radius=15},
    {x=-28,y=46,type="circle",purpose="vulnerability",radius=15},
    {x=-38,y=62.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=-38.666666666667,y=80.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=22,y=24,type="circle",purpose="defense",radius=15},
    {x=28,y=-54,type="circle",purpose="defense",radius=12},
  },
  {
    {x=77.666666666667,y=-29,type="circle",purpose="attack",radius=10},
    {x=69.333333333333,y=-15.333333333333,type="circle",purpose="attack",radius=15},
    {x=48.333333333333,y=-15.666666666667,type="circle",purpose="attack",radius=15},
    {x=28.333333333333,y=-14,type="circle",purpose="attack",radius=15},
    {x=29,y=-36.333333333333,type="circle",purpose="defense",radius=10},
    {x=-10,y=-77.666666666667,type="circle",purpose="vulnerability",radius=24},
    {x=-10.333333333333,y=-31.333333333333,type="circle",purpose="vulnerability",radius=30},
    {x=-33,y=-35.666666666667,type="circle",purpose="vulnerability",radius=18},
    {x=-37.333333333333,y=-6.6666666666667,type="circle",purpose="vulnerability",radius=18},
    {x=-22,y=12.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=-30,y=32.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=-36,y=51.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=-38,y=76,type="circle",purpose="vulnerability",radius=15},
  },
  {
    {x=30.666666666667,y=31.333333333333,type="circle",purpose="vulnerability",radius=13},
    {x=30.666666666667,y=48.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=36.333333333333,y=10,type="circle",purpose="defense",radius=15},
    {x=-7.3333333333333,y=-72.666666666667,type="circle",purpose="vulnerability",radius=24},
    {x=-12,y=-31.333333333333,type="circle",purpose="vulnerability",radius=30},
    {x=-4.6666666666667,y=-6.6666666666667,type="circle",purpose="vulnerability",radius=21},
    {x=-20,y=18,type="circle",purpose="vulnerability",radius=15},
    {x=-31.333333333333,y=40,type="circle",purpose="vulnerability",radius=15},
    {x=-41.333333333333,y=60,type="circle",purpose="vulnerability",radius=15},
    {x=-44.666666666667,y=76.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=19.333333333333,y=-0.66666666666667,type="circle",purpose="vulnerability",radius=13},
  },
  {
    {x=-2.3333333333333,y=-65,type="circle",purpose="vulnerability",radius=24},
    {x=-10,y=-22.666666666667,type="circle",purpose="vulnerability",radius=30},
    {x=-4,y=2,type="circle",purpose="vulnerability",radius=21},
    {x=20,y=-8.6666666666667,type="circle",purpose="vulnerability",radius=12},
    {x=15.333333333333,y=27.666666666667,type="circle",purpose="vulnerability",radius=24},
    {x=24.666666666667,y=59.333333333333,type="circle",purpose="vulnerability",radius=18},
    {x=-17.333333333333,y=30,type="circle",purpose="vulnerability",radius=15},
    {x=-22,y=51.333333333333,type="circle",purpose="vulnerability",radius=15},
    {x=-37.333333333333,y=66.666666666667,type="circle",purpose="vulnerability",radius=15},
    {x=-44.666666666667,y=79.666666666667,type="circle",purpose="vulnerability",radius=15},
  },
}

function bidenSpriteInfo:getSheet()
    return self.sheet;
end

function bidenSpriteInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return bidenSpriteInfo