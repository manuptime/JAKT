define ['cs!frames/models'], (FramesModels) ->
    {Frames, MixedupFrames, FrameGuess, Frame} = FramesModels
    makeData = () ->
        testFrame1 = Frame.create
            imagePath: "media/img/fixtures/frames/duck.jpg"
            order: 0
        testFrame2 = Frame.create
            imagePath: "media/img/fixtures/frames/duck.jpg"
            order: 1

        oldSpiceFrame1 =  Frame.create
            imagePath: "media/img/fixtures/frames/old_spice_swagger_01.png"
            order: 0
        oldSpiceFrame2 =  Frame.create
            imagePath: "media/img/fixtures/frames/old_spice_swagger_02.png"
            order: 1
        oldSpiceFrame3 =  Frame.create
            imagePath: "media/img/fixtures/frames/old_spice_swagger_03.png"
            order: 2
        oldSpiceFrame4 =  Frame.create
            imagePath: "media/img/fixtures/frames/old_spice_swagger_04.png"
            order: 3
        oldSpiceFrame5 =  Frame.create
            imagePath: "media/img/fixtures/frames/old_spice_swagger_05.png"
            order: 4
        oldSpiceFrame6 =  Frame.create
            imagePath: "media/img/fixtures/frames/old_spice_swagger_06.png"
            order: 5

        testFrames1 = Frames.create(
            frames:[
                testFrame1
                ]
            )
        oldSpiceFrames = Frames.create(
            frames: [
                oldSpiceFrame1
                oldSpiceFrame2
                oldSpiceFrame3
                oldSpiceFrame4
                oldSpiceFrame5
                oldSpiceFrame6
            ]
            video: "media/video/old_spice_swagger"
            logo: "media/img/fixtures/brand_logos/logo_Old_Spice.jpg"
        )

        oldSpiceFrames.init()

        georgeFrame1 =  Frame.create
            imagePath: "media/img/fixtures/frames/CG_1.png"
            order: 0
        georgeFrame2 =  Frame.create
            imagePath: "media/img/fixtures/frames/CG_2.png"
            order: 1
        georgeFrame3 =  Frame.create
            imagePath: "media/img/fixtures/frames/CG_3.png"
            order: 2
        georgeFrame4 =  Frame.create
            imagePath: "media/img/fixtures/frames/CG_4.png"
            order: 3
        georgeFrame5 =  Frame.create
            imagePath: "media/img/fixtures/frames/CG_5.png"
            order: 4
        georgeFrame6 =  Frame.create
            imagePath: "media/img/fixtures/frames/CG_6.png"
            order: 5

        testFrames1 = Frames.create(
            frames:[
                testFrame1
                ]
            )
        georgeFrames = Frames.create(
            frames: [
                georgeFrame1
                georgeFrame2
                georgeFrame3
                georgeFrame4
                georgeFrame5
                georgeFrame6
            ]
            video: "media/video/Curious_George_Wheres_the_Firedog_PBS_KIDS"
            logo: "media/img/fixtures/brand_logos/logo_PBS.jpg"
        )
        georgeFrames.init()


        subwayFrame1 =  Frame.create
            imagePath: "media/img/fixtures/frames/subway1.png"
            order: 0
        subwayFrame2 =  Frame.create
            imagePath: "media/img/fixtures/frames/subway2.png"
            order: 1
        subwayFrame3 =  Frame.create
            imagePath: "media/img/fixtures/frames/subway3.png"
            order: 2
        subwayFrame4 =  Frame.create
            imagePath: "media/img/fixtures/frames/subway4.png"
            order: 3
        subwayFrame5 =  Frame.create
            imagePath: "media/img/fixtures/frames/subway5.png"
            order: 4
        subwayFrame6 =  Frame.create
            imagePath: "media/img/fixtures/frames/subway6.png"
            order: 5

        testFrames1 = Frames.create(
            frames:[
                testFrame1
                ]
            )
        subwayFrames = Frames.create(
            frames: [
                subwayFrame1
                subwayFrame2
                subwayFrame3
                subwayFrame4
                subwayFrame5
                subwayFrame6
            ]
            video: "media/video/7w6i_360"
            logo: "media/img/fixtures/brand_logos/logo_Subway.jpg"
        )
        subwayFrames.init()


        hundaiFrame1 =  Frame.create
            imagePath: "media/img/fixtures/frames/H_1.png"
            order: 0
        hundaiFrame2 =  Frame.create
            imagePath: "media/img/fixtures/frames/H_2.png"
            order: 1
        hundaiFrame3 =  Frame.create
            imagePath: "media/img/fixtures/frames/H_3.png"
            order: 2
        hundaiFrame4 =  Frame.create
            imagePath: "media/img/fixtures/frames/H_4.png"
            order: 3
        hundaiFrame5 =  Frame.create
            imagePath: "media/img/fixtures/frames/H_5.png"
            order: 4
        hundaiFrame6 =  Frame.create
            imagePath: "media/img/fixtures/frames/H_6.png"
            order: 5

        hundaiFrames = Frames.create(
            frames: [
                hundaiFrame1
                hundaiFrame2
                hundaiFrame3
                hundaiFrame4
                hundaiFrame5
                hundaiFrame6
            ]
            video: "media/video/2013_Hyundai_Santa_Fe_Big_Game_Ad_Team_"
            logo: "media/img/fixtures/brand_logos/logo_hyundai.jpg"
        )
        hundaiFrames.init()


        doritosFashionistaFrame1 =  Frame.create
            imagePath: "media/img/fixtures/frames/Doritos_Fashionista_01.png"
            order: 0
        doritosFashionistaFrame2 =  Frame.create
            imagePath: "media/img/fixtures/frames/Doritos_Fashionista_02.png"
            order: 1
        doritosFashionistaFrame3 =  Frame.create
            imagePath: "media/img/fixtures/frames/Doritos_Fashionista_03.png"
            order: 2
        doritosFashionistaFrame4 =  Frame.create
            imagePath: "media/img/fixtures/frames/Doritos_Fashionista_04.png"
            order: 3
        doritosFashionistaFrame5 =  Frame.create
            imagePath: "media/img/fixtures/frames/Doritos_Fashionista_05.png"
            order: 4
        doritosFashionistaFrame6 =  Frame.create
            imagePath: "media/img/fixtures/frames/Doritos_Fashionista_06.png"
            order: 5

        testFrames1 = Frames.create(
            frames:[
                testFrame1
                ]
            )
        doritosFashionistaFrames = Frames.create(
            frames: [
                doritosFashionistaFrame1
                doritosFashionistaFrame2
                doritosFashionistaFrame3
                doritosFashionistaFrame4
                doritosFashionistaFrame5
                doritosFashionistaFrame6
            ]
            video: "media/video/Doritos_Fashionista"
            logo: "media/img/fixtures/brand_logos/logo_doritos.png"
        )
        doritosFashionistaFrames.init()

        # ------------------------------------------------------------ Kraft Miracle Whip
        #
        #
        miracleWhipFrame1 =  Frame.create
            imagePath: "media/img/fixtures/frames/MW_1.jpg"
            order: 0
        miracleWhipFrame2 =  Frame.create
            imagePath: "media/img/fixtures/frames/MW_2.jpg"
            order: 1
        miracleWhipFrame3 =  Frame.create
            imagePath: "media/img/fixtures/frames/MW_3.jpg"
            order: 2
        miracleWhipFrame4 =  Frame.create
            imagePath: "media/img/fixtures/frames/MW_4.jpg"
            order: 3
        miracleWhipFrame5 =  Frame.create
            imagePath: "media/img/fixtures/frames/MW_5.jpg"
            order: 4
        miracleWhipFrame6 =  Frame.create
            imagePath: "media/img/fixtures/frames/MW_6.jpg"
            order: 5

        testFrames1 = Frames.create(
            frames:[
                testFrame1
                ]
            )
        miracleWhipFrames = Frames.create(
            frames: [
                miracleWhipFrame1
                miracleWhipFrame2
                miracleWhipFrame3
                miracleWhipFrame4
                miracleWhipFrame5
                miracleWhipFrame6
            ]
            video: "media/video/Miracle_Whip"
            logo: "media/img/fixtures/brand_logos/logo_miracleWhip.png"
        )
        miracleWhipFrames.init()

        # ------------------------------------------------------------ State Farm "Good Neighbor"
        #
        #
        stateFarmFrame1 =  Frame.create
            imagePath: "media/img/fixtures/frames/stateFarm_1.png"
            order: 0
        stateFarmFrame2 =  Frame.create
            imagePath: "media/img/fixtures/frames/stateFarm_2.png"
            order: 1
        stateFarmFrame3 =  Frame.create
            imagePath: "media/img/fixtures/frames/stateFarm_3.png"
            order: 2
        stateFarmFrame4 =  Frame.create
            imagePath: "media/img/fixtures/frames/stateFarm_4.png"
            order: 3
        stateFarmFrame5 =  Frame.create
            imagePath: "media/img/fixtures/frames/stateFarm_5.png"
            order: 4
        stateFarmFrame6 =  Frame.create
            imagePath: "media/img/fixtures/frames/stateFarm_6.png"
            order: 5

        testFrames1 = Frames.create(
            frames:[
                testFrame1
                ]
            )
        stateFarmFrames = Frames.create(
            frames: [
                stateFarmFrame1
                stateFarmFrame2
                stateFarmFrame3
                stateFarmFrame4
                stateFarmFrame5
                stateFarmFrame6
            ]
            video: "media/video/StateFarm"
            logo: "media/img/fixtures/brand_logos/logo_StateFarm.png"
        )
        stateFarmFrames.init()

        # ------------------------------------------------------------ IBM "Lower Crime"
        #
        #
        ibmCrimeFrame1 =  Frame.create
            imagePath: "media/img/fixtures/frames/ibmCrime_1.png"
            order: 0
        ibmCrimeFrame2 =  Frame.create
            imagePath: "media/img/fixtures/frames/ibmCrime_2.png"
            order: 1
        ibmCrimeFrame3 =  Frame.create
            imagePath: "media/img/fixtures/frames/ibmCrime_3.png"
            order: 2
        ibmCrimeFrame4 =  Frame.create
            imagePath: "media/img/fixtures/frames/ibmCrime_4.png"
            order: 3
        ibmCrimeFrame5 =  Frame.create
            imagePath: "media/img/fixtures/frames/ibmCrime_5.png"
            order: 4
        ibmCrimeFrame6 =  Frame.create
            imagePath: "media/img/fixtures/frames/ibmCrime_6.png"
            order: 5

        testFrames1 = Frames.create(
            frames:[
                testFrame1
                ]
            )
        ibmCrimeFrames = Frames.create(
            frames: [
                ibmCrimeFrame1
                ibmCrimeFrame2
                ibmCrimeFrame3
                ibmCrimeFrame4
                ibmCrimeFrame5
                ibmCrimeFrame6
            ]
            video: "media/video/ibm_crime"
            logo: "media/img/fixtures/brand_logos/logo_ibm.png"
        )
        ibmCrimeFrames.init()

        # ------------------------------------------------------------ Charmin Ultra Soft
        #
        #
        charminFrame1 =  Frame.create
            imagePath: "media/img/fixtures/frames/charmin_01.png"
            order: 0
        charminFrame2 =  Frame.create
            imagePath: "media/img/fixtures/frames/charmin_02.png"
            order: 1
        charminFrame3 =  Frame.create
            imagePath: "media/img/fixtures/frames/charmin_03.png"
            order: 2
        charminFrame4 =  Frame.create
            imagePath: "media/img/fixtures/frames/charmin_04.png"
            order: 3
        charminFrame5 =  Frame.create
            imagePath: "media/img/fixtures/frames/charmin_05.png"
            order: 4
        charminFrame6 =  Frame.create
            imagePath: "media/img/fixtures/frames/charmin_06.png"
            order: 5

        testFrames1 = Frames.create(
            frames:[
                testFrame1
                ]
            )
        charminFrames = Frames.create(
            frames: [
                charminFrame1
                charminFrame2
                charminFrame3
                charminFrame4
                charminFrame5
                charminFrame6
            ]
            video: "media/video/charmin"
            logo: "media/img/fixtures/brand_logos/logo_charmin.png"
        )
        charminFrames.init()

        # ------------------------------------------------------------ Verizone Share Everything
        #
        #
        verizonShareFrame1 =  Frame.create
            imagePath: "media/img/fixtures/frames/V_1.png"
            order: 0
        verizonShareFrame2 =  Frame.create
            imagePath: "media/img/fixtures/frames/V_2.png"
            order: 1
        verizonShareFrame3 =  Frame.create
            imagePath: "media/img/fixtures/frames/V_3.png"
            order: 2
        verizonShareFrame4 =  Frame.create
            imagePath: "media/img/fixtures/frames/V_4.png"
            order: 3
        verizonShareFrame5 =  Frame.create
            imagePath: "media/img/fixtures/frames/V_5.png"
            order: 4
        verizonShareFrame6 =  Frame.create
            imagePath: "media/img/fixtures/frames/V_6.png"
            order: 5

        testFrames1 = Frames.create(
            frames:[
                testFrame1
                ]
            )
        verizonShareFrames = Frames.create(
            frames: [
                verizonShareFrame1
                verizonShareFrame2
                verizonShareFrame3
                verizonShareFrame4
                verizonShareFrame5
                verizonShareFrame6
            ]
            video: "media/video/FA_Verizon_ShareEverything_Baseball"
            logo: "media/img/fixtures/brand_logos/logo_Verizon.png"
        )
        verizonShareFrames.init()

        # ------------------------------------------------------------ 2014 Lexus IS 250 "Stand Out"
        #
        #
        lexusstandoutFrame1 =  Frame.create
            imagePath: "media/img/fixtures/frames/lexus_standout_01.jpg"
            order: 0
        lexusstandoutFrame2 =  Frame.create
            imagePath: "media/img/fixtures/frames/lexus_standout_02.jpg"
            order: 1
        lexusstandoutFrame3 =  Frame.create
            imagePath: "media/img/fixtures/frames/lexus_standout_03.jpg"
            order: 2
        lexusstandoutFrame4 =  Frame.create
            imagePath: "media/img/fixtures/frames/lexus_standout_04.jpg"
            order: 3
        lexusstandoutFrame5 =  Frame.create
            imagePath: "media/img/fixtures/frames/lexus_standout_05.jpg"
            order: 4
        lexusstandoutFrame6 =  Frame.create
            imagePath: "media/img/fixtures/frames/lexus_standout_06.jpg"
            order: 5

        testFrames1 = Frames.create(
            frames:[
                testFrame1
                ]
            )
        lexusstandoutFrames = Frames.create(
            frames: [
                lexusstandoutFrame1
                lexusstandoutFrame2
                lexusstandoutFrame3
                lexusstandoutFrame4
                lexusstandoutFrame5
                lexusstandoutFrame6
            ]
            video: "media/video/Lexus_StandOut"
            logo: "media/img/fixtures/brand_logos/lexus_logo.jpg"
        )
        lexusstandoutFrames.init()

        # ------------------------------------------------------------ Purina Friskies Grillers
        #
        #
        purinaFriskiesFrame1 =  Frame.create
            imagePath: "media/img/fixtures/frames/Friskies_Grillers_01.jpg"
            order: 0
        purinaFriskiesFrame2 =  Frame.create
            imagePath: "media/img/fixtures/frames/Friskies_Grillers_02.jpg"
            order: 1
        purinaFriskiesFrame3 =  Frame.create
            imagePath: "media/img/fixtures/frames/Friskies_Grillers_03.jpg"
            order: 2
        purinaFriskiesFrame4 =  Frame.create
            imagePath: "media/img/fixtures/frames/Friskies_Grillers_04.jpg"
            order: 3
        purinaFriskiesFrame5 =  Frame.create
            imagePath: "media/img/fixtures/frames/Friskies_Grillers_05.jpg"
            order: 4
        purinaFriskiesFrame6 =  Frame.create
            imagePath: "media/img/fixtures/frames/Friskies_Grillers_06.jpg"
            order: 5

        testFrames1 = Frames.create(
            frames:[
                testFrame1
                ]
            )
        purinaFriskiesFrames = Frames.create(
            frames: [
                purinaFriskiesFrame1
                purinaFriskiesFrame2
                purinaFriskiesFrame3
                purinaFriskiesFrame4
                purinaFriskiesFrame5
                purinaFriskiesFrame6
            ]
            video: "media/video/Friskies_Grillers"
            logo: "media/img/fixtures/brand_logos/purina_friskies_logo.jpg"
        )
        purinaFriskiesFrames.init()

        return {
            testFrame1: testFrame1
            testFrame2: testFrame2
            testFrames1: testFrames1
            oldSpiceFrames: oldSpiceFrames
            oldSpiceFrame1:oldSpiceFrame1
            oldSpiceFrame2:oldSpiceFrame2
            oldSpiceFrame3:oldSpiceFrame3
            oldSpiceFrame4:oldSpiceFrame4
            oldSpiceFrame5:oldSpiceFrame5
            oldSpiceFrame6:oldSpiceFrame6
            georgeFrames: georgeFrames
            georgeFrame1:georgeFrame1
            georgeFrame2:georgeFrame2
            georgeFrame3:georgeFrame3
            georgeFrame4:georgeFrame4
            georgeFrame5:georgeFrame5
            georgeFrame6:georgeFrame6
            subwayFrames: subwayFrames
            subwayFrame1:subwayFrame1
            subwayFrame2:subwayFrame2
            subwayFrame3:subwayFrame3
            subwayFrame4:subwayFrame4
            subwayFrame5:subwayFrame5
            subwayFrame6:subwayFrame6
            hundaiFrames:hundaiFrames
            doritosFashionistaFrames:doritosFashionistaFrames
            miracleWhipFrames:miracleWhipFrames
            stateFarmFrames:stateFarmFrames
            ibmCrimeFrames:ibmCrimeFrames
            charminFrames:charminFrames
            verizonShareFrames:verizonShareFrames
            lexusstandoutFrames:lexusstandoutFrames
            purinaFriskiesFrames:purinaFriskiesFrames

        }
    return {makeData:makeData}