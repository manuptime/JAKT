define ['cs!dropblocks/models'], (DropblocksModels) ->
    {Dropblocks} = DropblocksModels
    makeData = () ->
        testDropblocks = Dropblocks.create(
            video: "media/video/old_spice_swagger"
            logo: "media/img/fixtures/brand_logos/logo_Old_Spice.jpg"
        )

        doritosDropblocks = Dropblocks.create(
            video: "media/video/Doritos_Fashionista"
            logo: "media/img/fixtures/brand_logos/logo_doritos.png"
        )

        oldSpiceDropblocks = Dropblocks.create(
            video: "media/video/old_spice_swagger"
            logo: "media/img/fixtures/brand_logos/logo_Old_Spice.jpg"
        )

        oreoDropblocks = Dropblocks.create(
            video: "media/video/OREO_Whisper_Fight"
            logo: "media/img/fixtures/brand_logos/logo_oreo.png"
        )

        hyundaiDropblocks = Dropblocks.create(
            video: "media/video/2013_Hyundai_Santa_Fe_Big_Game_Ad_Team_"
            logo: "media/img/fixtures/brand_logos/logo_hyundai.jpg"
        )

        miraclewhipDropblocks = Dropblocks.create(
            video: "media/video/Miracle_Whip"
            logo: "media/img/fixtures/brand_logos/logo_miracleWhip.png"
        )

        pepsiDropblocks = Dropblocks.create(
            video: "media/video/Pepsi"
            logo: "media/img/fixtures/brand_logos/logo_pepsi.jpg"
        )

        angelsoftDropblocks = Dropblocks.create(
            video: "media/video/Moxie_AngelSoft_TP_Factory.mov.ff"
            logo: "media/img/fixtures/brand_logos/logo_angelsoft.png"
        )

        return {
            testDropblocks:testDropblocks
            doritosDropblocks:doritosDropblocks
            oldSpiceDropblocks:oldSpiceDropblocks
            oreoDropblocks:oreoDropblocks
            hyundaiDropblocks:hyundaiDropblocks
            miraclewhipDropblocks:miraclewhipDropblocks
            pepsiDropblocks:pepsiDropblocks
            angelsoftDropblocks:angelsoftDropblocks
        }
    return {makeData:makeData}