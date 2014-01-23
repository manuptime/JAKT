define ['cs!puzzle/models'], (PuzzleModels) ->
    {Puzzle} = PuzzleModels
    makeData = () ->
        testPuzzle = Puzzle.create(
            video: "media/video/old_spice_swagger"
            logo: "media/img/fixtures/brand_logos/logo_Old_Spice.jpg"
        )

        doritosPuzzle = Puzzle.create(
            video: "media/video/Doritos_Fashionista"
            logo: "media/img/fixtures/brand_logos/logo_doritos.png"
        )

        oldSpicePuzzle = Puzzle.create(
            video: "media/video/old_spice_swagger"
            logo: "media/img/fixtures/brand_logos/logo_Old_Spice.jpg"
        )

        oreoPuzzle = Puzzle.create(
            video: "media/video/OREO_Whisper_Fight"
            logo: "media/img/fixtures/brand_logos/logo_oreo.png"
        )

        hyundaiPuzzle = Puzzle.create(
            video: "media/video/2013_Hyundai_Santa_Fe_Big_Game_Ad_Team_"
            logo: "media/img/fixtures/brand_logos/logo_hyundai.jpg"
        )

        miraclewhipPuzzle = Puzzle.create(
            video: "media/video/Miracle_Whip"
            logo: "media/img/fixtures/brand_logos/logo_miracleWhip.png"
        )

        pepsiPuzzle = Puzzle.create(
            video: "media/video/Pepsi"
            logo: "media/img/fixtures/brand_logos/logo_pepsi.jpg"
        )

        angelsoftPuzzle = Puzzle.create(
            video: "media/video/Moxie_AngelSoft_TP_Factory.mov.ff"
            logo: "media/img/fixtures/brand_logos/logo_angelsoft.png"
        )

        freshdirectPuzzle = Puzzle.create(
            video: "media/video/FreshDirect_winecheese"
            logo: "media/img/fixtures/brand_logos/freshdirect_logo.png"
        )

        purinaProPlanPuzzle = Puzzle.create(
            video: "media/video/Purina_ProPlan_Soaring"
            logo: "media/img/fixtures/brand_logos/purina_proplan_logo.jpg"
        )

        return {
            testPuzzle:testPuzzle
            doritosPuzzle:doritosPuzzle
            oldSpicePuzzle:oldSpicePuzzle
            oreoPuzzle:oreoPuzzle
            hyundaiPuzzle:hyundaiPuzzle
            miraclewhipPuzzle:miraclewhipPuzzle
            pepsiPuzzle:pepsiPuzzle
            angelsoftPuzzle:angelsoftPuzzle
            freshdirectPuzzle:freshdirectPuzzle
            purinaProPlanPuzzle:purinaProPlanPuzzle
        }
    return {makeData:makeData}