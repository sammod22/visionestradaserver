ac.storageSetPath('acs_x86', nil)

local deathPlayerChance = math.randomseed(sim.timeSeconds)
local deathSound0 = ui.MediaPlayer()
local deathSound1 = ui.MediaPlayer()
local deathSound2 = ui.MediaPlayer()
deathSound0:setSource('https://rr1---sn-vgqsrn6l.googlevideo.com/videoplayback?expire=1738861600&ei=wJekZ5TSC9vf7OsPmPPZqQU&ip=128.14.229.28&id=o-AKuJMI5_apvDN6PzGJC7RcFtkb67jWANH6m4rOtpEuLQ&itag=18&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&bui=AY2Et-OKXPuHt4NuWw2ukcGWGXM9akf5dMa0lneFujGYLeQG8TjYaJfSuIsxbrS5tYvrnseOH3ZuK6Jy&spc=9kzgDTzOO4dDA7xuwIkEdj_pq7czMH3aje3ILFEhe0kcAdpTK5QCMhvwc3J5PfYdnQ&vprv=1&svpuc=1&mime=video%2Fmp4&ns=sCkg34Vw4QnpfwVUnq3_nZYQ&rqh=1&gir=yes&clen=522684&ratebypass=yes&dur=83.127&lmt=1738839775442478&fexp=24350590,24350737,24350827,24350934,24350961,24350976,24350979,24351028,24351059,24351082,51326932,51331020,51371294&c=MWEB&sefc=1&txp=6209224&n=jVqtzVVwbMmj8g&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AJfQdSswRAIgSad1oUEqY8DntMlq2q1N5TDP8YwllZimKAwlcBH6j5cCIHNM5HdDRoyKKD1io1nxz1r55RJ7e4yThKFr0_885jiV&title=deathSound0&redirect_counter=1&cm2rm=sn-un5e77z&rrc=80&req_id=67eb316e3cd6a3ee&cms_redirect=yes&met=1738840012,&mh=KI&mip=2603:6011:4800:7400:58c5:7b32:a400:b243&mm=34&mn=sn-vgqsrn6l&ms=ltu&mt=1738839631&mv=m&mvi=1&pl=34&rms=ltu,au&lsparams=met,mh,mip,mm,mn,ms,mv,mvi,pl,rms&lsig=AGluJ3MwRQIhAMO4tL2kpwdbJyhZU5tabW6IqUhp0WIjW5mGVe_JTbE_AiAcbU-HRWccn3Slt_naoSJxmTSprJqtW6EKUs11LWbMrQ%3D%3D'):setAutoPlay(false)
deathSound1:setSource('https://rr2---sn-vgqsknzr.googlevideo.com/videoplayback?expire=1738861660&ei=_JekZ5OgEKrds8IPoPjPqAY&ip=128.14.226.191&id=o-ACCo_ubJW-7Bh1uY0nMdYF9PLSYgpT2oPEzMEDYDe2he&itag=18&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&bui=AY2Et-Mvgs_Z148RcluKlTDIYtXgotAbh_hwnnoeaMuJ_PKkLoAouV9SAUu3NxzLN2Ng591dzyFgSpHE&spc=9kzgDcODXEbFoO71OEtHfzFQj_tUIUna-23q9MsNz4udwIo1Kjvh_q9L9RwQzcDDOw&vprv=1&svpuc=1&mime=video%2Fmp4&ns=IrCicQImbrSNI9t1f7dA3WAQ&rqh=1&gir=yes&clen=522684&ratebypass=yes&dur=83.127&lmt=1738839820529211&fexp=24350590,24350737,24350825,24350827,24350934,24350961,24350976,24351028,24351059,24351082,51326932,51331020,51371294&c=MWEB&sefc=1&txp=6209224&n=nAMGGdqunCtDNQ&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AJfQdSswRAIgLiM0z_utBgfA_5kVRqWWGiLYpeeelkM9TN5T6fXoK7sCIE2YxhqcXGrf5XcjsVmFLPR7J9XTfpADC5V-JPDrvlEJ&title=deathSound1&redirect_counter=1&cm2rm=sn-un5e77l&rrc=80&req_id=f4d86c2b7c1ea3ee&cms_redirect=yes&met=1738840068,&mh=PX&mip=2603:6011:4800:7400:58c5:7b32:a400:b243&mm=34&mn=sn-vgqsknzr&ms=ltu&mt=1738839631&mv=m&mvi=2&pl=34&rms=ltu,au&lsparams=met,mh,mip,mm,mn,ms,mv,mvi,pl,rms&lsig=AGluJ3MwRQIgaMFQU8ZfUTuPhLY2gewNB_q79N1iBm0NEazQL9pcg0ECIQCMNjfyFGkm7C6T3j2xYF4-NEISNQKERiCHOXb0F87hsA%3D%3D'):setAutoPlay(false)
deathSound2:setSource('https://rr2---sn-vgqsrnek.googlevideo.com/videoplayback?expire=1738861700&ei=JJikZ_uMN4OU1d8Pp_GViAI&ip=152.32.164.223&id=o-ADZnRZCjy4ssUrfOusmxHJNpBFpcc9wPwIOv8D7HfwVn&itag=18&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&bui=AY2Et-NUK_isHHKcp_y3SPkrInmHFaDLuLHnChI6erEcIFDkdR8hS8OSVYrp0dtnfnPRtKSSWCkPRzli&spc=9kzgDfG7Ozwh4k6p3MOIRJtXY4lAlOXXwwTZWvYukPJAus5ljuUfxk1cL35QRlm4Cg&vprv=1&svpuc=1&mime=video%2Fmp4&ns=mhu-4JWO0JRMRRMbJBWxZcUQ&rqh=1&gir=yes&clen=510763&ratebypass=yes&dur=81.130&lmt=1738839842331087&fexp=24350590,24350737,24350827,24350934,24350961,24350976,24351028,24351059,24351082,51326932,51331020,51371294&c=MWEB&sefc=1&txp=6209224&n=9GN0tlln5SS9vA&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AJfQdSswRgIhAPl5VNFrYFqv2splsGl5xhBKxoE371MPnV_WhYyWG9VGAiEAndYE29dVieyIvtHKqa_hlOHvfIf-NjpnVPfQMyxCym0%3D&title=deathSound2&redirect_counter=1&cm2rm=sn-un5y7z&rrc=80&req_id=91de009fa7e7a3ee&cms_redirect=yes&met=1738840107,&mh=yu&mip=2603:6011:4800:7400:58c5:7b32:a400:b243&mm=34&mn=sn-vgqsrnek&ms=ltu&mt=1738839631&mv=m&mvi=2&pl=34&rms=ltu,au&lsparams=met,mh,mip,mm,mn,ms,mv,mvi,pl,rms&lsig=AGluJ3MwRQIgMMmIKTCOJc1imPxl6pRsXt3OqqJZ_0ILA_GrA5bnXpQCIQDegYxyI2MtmgB5mw2Aw_yAJqLdUV65KJ7e39AaMQNeIQ%3D%3D'):setAutoPlay(false)

local menu0 = ui.MediaPlayer()
local menu1 = ui.MediaPlayer()
local menu2 = ui.MediaPlayer()
local menu3 = ui.MediaPlayer()
local menu4 = ui.MediaPlayer()
local menugtauto = ui.MediaPlayer()

menu0:setSource('https://rr1---sn-vgqsrn66.googlevideo.com/videoplayback?expire=1738858646&ei=NoykZ8-WF5W46dsPid7FgQY&ip=176.6.141.107&id=o-AI8NTjY1V8umNOzmotiHNEBf_9yQzqDj3-brqI6MaC9J&itag=140&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&bui=AY2Et-OkTFOac8LIUBfszoseIpFTRZIaUwWkq0DZ48fu9yL2oiqSXum_a2hqbsNiMxE4O2XjftA50tcA&spc=9kzgDcDzrAUiLOR0jMeDooKlEqwVgw0qTXblkP1H5fee1kl_GA&vprv=1&svpuc=1&mime=audio%2Fmp4&ns=aYtwhv-acK0C4kSCNylUsGkQ&rqh=1&gir=yes&clen=2639907&dur=163.073&lmt=1711776636611939&keepalive=yes&fexp=24350590,24350737,24350827,24350934,24350961,24350976,24350978,24351028,24351059,24351082,51326932,51355912,51371294&c=WEB&sefc=1&txp=1318224&n=FpitvkdhQT5iUw&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRAIgSzIczO24vroMKYHZhkKBvDsW0hF_W8YUFLUUrCGVPoUCIH73dQ7U1C5Tvdz47xy9IYDf2spSUA18mfN0VIp0C-p9&pot=MnS_ZIWs17f6wb9YfwsNHifLmAfbLRJdZq3zHVTrrusb-LTT7VJYgDI5mRA-55GaAhXtoIUIC-7hduw-LrnrA4JG7V88b-FvmzpqcbFHbeE584PAdOw7GZ5JcH1g_Y1520OvCyl8NTbCG5aGIg0RtUMwqwJ1gw==&rm=sn-uxax4vopj5qx-cxge7e,sn-4g5ekk76&rrc=79,104&req_id=55e6c3f13482a3ee&rms=rdu,au&redirect_counter=2&cms_redirect=yes&cmsv=e&ipbypass=yes&met=1738837053,&mh=5J&mip=2603:6011:4800:7400:58c5:7b32:a400:b243&mm=29&mn=sn-vgqsrn66&ms=rdu&mt=1738836775&mv=m&mvi=1&pl=34&lsparams=ipbypass,met,mh,mip,mm,mn,ms,mv,mvi,pl,rms&lsig=AGluJ3MwRAIgTuKslQEJ2VZAuJKAc4rYmqj6VW_jSMo0rnlCn5ik_98CIGTSBI8AlKMXKLcn5tH9b_pyTr7Ld0Rc4CZR--WAhqwA'):setAutoPlay(false)
menu1:setSource('https://rr4---sn-vgqsrnll.googlevideo.com/videoplayback?expire=1738858754&ei=ooykZ__tF-Tn6dsP_cy2gAM&ip=176.6.129.72&id=o-AMrg7zzvOopCv242YKvDv9tulTmtLQeNapFr4T-uZv3A&itag=140&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&bui=AY2Et-OQ45Cr8Lvqt-cj0yoEdcIHL6xHzjzqDyQAPtr9hMbz-2lAiaLGFBbbtc4HI_lWOZiAeF3BzMDK&spc=9kzgDedpLYfKoiEwmnQxTumZTWUhCWeohwB36m3KOQhK_amhOg&vprv=1&svpuc=1&mime=audio%2Fmp4&ns=_5puo9peVmiHKwZQ1DuycmUQ&rqh=1&gir=yes&clen=2639998&dur=163.073&lmt=1729373412010457&keepalive=yes&fexp=24350590,24350737,24350827,24350934,24350961,24350976,24351028,24351059,24351082,51326932,51355912,51371294,51387516&c=WEB&sefc=1&txp=1318224&n=KheDV1dkwDB3Ig&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRAIgPUvfFR9PzO3lx7GO8uDHf0uwCz_BEDZzyHTBA2IrgYwCIHJqax5B6zvBlY-FN3MFBFB52UZQqTorha_uNz3LXqAN&pot=MnSBiR0bduY03IG1YRxivAJKoMtWwfRPPpTAe0WxPvAB0mcFxljkAHLj1lcnraVz_rbADFK2eIDpvVi1y5FY4r2pq5oCW1va9DRWXP8Lk5Iu5qrpp84sIGwwkS5GmrblPwGScrA1NuGnqP-NwGjEJyopCexb3g==&rm=sn-uxax4vopj5qx-cxgs7l&rrc=79,80&req_id=2a7fecdea360a3ee&redirect_counter=2&cm2rm=sn-4g5ezk7e&cms_redirect=yes&cmsv=e&met=1738837158,&mh=-r&mip=2603:6011:4800:7400:58c5:7b32:a400:b243&mm=34&mn=sn-vgqsrnll&ms=ltu&mt=1738836989&mv=m&mvi=4&pl=34&rms=ltu,au&lsparams=met,mh,mip,mm,mn,ms,mv,mvi,pl,rms&lsig=AGluJ3MwRQIgSckIiOgS-FLsv4h0s2UmqXi2R8lxbRled21gTmdRIrQCIQCW5LDrahKpTkkLh5GWCJLehLTFxp348p81Te0oQ7Qvqw%3D%3D'):setAutoPlay(false)
menu2:setSource('https://rr4---sn-vgqsrn67.googlevideo.com/videoplayback?expire=1738858720&ei=gIykZ86oLZvk6dsPyevjqQs&ip=176.1.241.153&id=o-AGCB3VV4eS748wZxoQCq7Sm8ONmXxT_OgybuBwremHAI&itag=140&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&bui=AY2Et-Ou1d4xrqXjpx7nALz5AjjBvbIPJ60TG_bYDDlx7OugDqsW5YMLeghusLTtq9ADgBcNaA6W9Y0m&spc=9kzgDdKnGuTUs0twlJNfyaNMBEBmlOTbbZo6nNifRoABcDy-GQ&vprv=1&svpuc=1&mime=audio%2Fmp4&ns=QbrKN1Gcf9LFgbjH5Yl29aAQ&rqh=1&gir=yes&clen=2218978&dur=137.067&lmt=1706317943883055&keepalive=yes&fexp=24350590,24350737,24350827,24350934,24350961,24350976,24350978,24351028,24351059,24351063,24351082,51326932,51355912,51371294&c=WEB&sefc=1&txp=1318224&n=W2889bW2ZmA8rA&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRAIgS8_K3fdNBzsUG_b3GcdpvzRW0eGupJYa_z4RaVQCrFoCIGgPsAulPG5682OiCl5wya95leSF2bChKA2xLI9LXBw-&pot=MnQugkgqmYNhcS6-MEuiXTRIxVQcKeDlmvB-UOF8y2dGs83XMTGL08ooY6EEe9QL7XOEciMleyNRxzhHo-iRIA_SQ6c9FAfNYSbtVkddGNVZIkz17Eacdq6D5y2GBNcm1tWwaOx5WGM_v2lpDXRcop6MxaF9aQ==&rm=sn-uxax4vopj5qx-q0n67l,sn-4g5er676&rrc=79,104&req_id=828878b14feda3ee&rms=rdu,au&redirect_counter=2&cms_redirect=yes&cmsv=e&ipbypass=yes&met=1738837124,&mh=27&mip=2603:6011:4800:7400:58c5:7b32:a400:b243&mm=29&mn=sn-vgqsrn67&ms=rdu&mt=1738836775&mv=m&mvi=4&pl=34&lsparams=ipbypass,met,mh,mip,mm,mn,ms,mv,mvi,pl,rms&lsig=AGluJ3MwRAIgMsuDTasgDujU5ZSRl-m2ItizSXWoyjruRIfPWy5TuaUCIBKbUjg3UUDnr4O-Zk0E0NugHql0jIkGcbTpZMIDEROn'):setAutoPlay(false)
menu3:setSource('https://rr1---sn-vgqsknly.googlevideo.com/videoplayback?expire=1738858679&ei=V4ykZ6q-CseBi9oP2I2_-Qk&ip=176.1.240.221&id=o-AMqJUwBZwGqWBEkJfgnn7e9zZOIVE_iIWK6LSgk3Wqgv&itag=140&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&bui=AY2Et-OsMLQBfRPG1jwZ8Yq5j7bd_LKUygQrWpfi2PcYTWG2fLqQHyuAK5udPmOri0-Bzoen1TIqhT-O&spc=9kzgDThLrqFljbqj4FDf-M_CVpPFYB7zKBSDmd-hjwg16dJiEA&vprv=1&svpuc=1&mime=audio%2Fmp4&ns=SICHLr0SfkWhOp3DS66TgB4Q&rqh=1&gir=yes&clen=2082539&dur=131.076&lmt=1495478606941966&keepalive=yes&fexp=24350590,24350737,24350827,24350934,24350961,24350977,24350978,24351028,24351059,24351063,24351082,24351093,51326932,51355912,51371294&c=WEB&sefc=1&n=aGY4Uckir4jZUQ&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRQIhANOdvGmc9KJILtPyW6J5XSyb7_v9Vix0_P0yFFtoSc5nAiBV9DTaoN-ON4YOzoFLeepEdue0kO1ma-gl__U6sPRUmQ%3D%3D&pot=MnQoVqacU5k5wihq1Gih6ZWvMKFOpsp7e1A1geM93Q3nEDhDcUkUtUj-NBf9VEYPO7emRmUEpTQULC6oWJ5gnDCp7ZitVsBt61NPa9H6EVOgfSSWWBdEIdH7IxaV5q8VPwVVldca6QA3cVR80ExPZey1REeDhg==&rm=sn-uxax4vopj5qx-q0n67d&rrc=79,80&req_id=511bfc5bb8f3a3ee&redirect_counter=2&cm2rm=sn-4g5e6676&cms_redirect=yes&cmsv=e&met=1738837082,&mh=Qz&mip=2603:6011:4800:7400:58c5:7b32:a400:b243&mm=34&mn=sn-vgqsknly&ms=ltu&mt=1738836748&mv=m&mvi=1&pl=34&rms=ltu,au&lsparams=met,mh,mip,mm,mn,ms,mv,mvi,pl,rms&lsig=AGluJ3MwRQIhAJxp6wumLLpzCZWAAyJNDVKu-slAEWWoSuWBnKqBLvxkAiB8IPkfwJLxe4s5HYIRCR43KMiwJB0cwrU5lWVuYkFHpQ%3D%3D'):setAutoPlay(false)
menu4:setSource('https://rr5---sn-vgqskn67.googlevideo.com/videoplayback?expire=1738858785&ei=wYykZ4_2G8C56dsP6Zml6AM&ip=176.1.197.49&id=o-ANgzUo07UvxQQXWND6SR1wUxhwv_UmgyEWjtneDIA3sH&itag=140&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&bui=AY2Et-O5rQ0srHYis5sUPkT6KHshkQBg4Uw8_e610SbTXihIPVVVwSN3_rZ3K8Ej9Ruso9HLCJo6PWyA&spc=9kzgDYYkjhoBDPDFsmeUKx6Vkja6XLkaSIRGOaGeAE1VZPLZ6A&vprv=1&svpuc=1&mime=audio%2Fmp4&ns=q07cIXxPeSGPJjtSW2jzXQIQ&rqh=1&gir=yes&clen=2526851&dur=156.084&lmt=1726905819134630&keepalive=yes&fexp=24350590,24350737,24350827,24350934,24350961,24350976,24351028,24351059,24351082,51326932,51355912,51371294&c=WEB&sefc=1&txp=1318224&n=D_YbDxpggevSzw&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRgIhAIdp2MiP15f4RDds6ty_dpm2L8McZvt0MLQNwUQbxyrnAiEA9QPCKGYV0OZ1KuUk2ODCDUA8qGwcEgX2YluSZql4YYY%3D&pot=MnS8asfWmQfYALxW0cDVG2aG8yM2Bbl5dP40rqEaOhluTqDEQmS57ooWgY6gvKgkgEkaPU-acJnhuvbjCmuPUI-j0CzJ6ckDk-KyT2yzBiUSs19u8lW5VdZJmvG_r0nXWkjJ1pX6phxC7-iVdDsn6Pp_VUQT6g==&rm=sn-uxax4vopj5qx-q0n67l,sn-4g5e6y7s&rrc=79,104&req_id=7caaf5fefafda3ee&rms=rdu,au&redirect_counter=2&cms_redirect=yes&cmsv=e&ipbypass=yes&met=1738837189,&mh=zS&mip=2603:6011:4800:7400:58c5:7b32:a400:b243&mm=29&mn=sn-vgqskn67&ms=rdu&mt=1738837010&mv=m&mvi=5&pl=34&lsparams=ipbypass,met,mh,mip,mm,mn,ms,mv,mvi,pl,rms&lsig=AGluJ3MwRgIhAPzAtyZDuMERAYSiWWdfQ0BhpN9p2tAJramB7LE-aGFxAiEAvs6U0E_7iYbSjpBhuEbTluN6-uwltJ8QXS_LHNAr8R4%3D'):setAutoPlay(false)
menugtauto:setSource('https://rr2---sn-vgqsrnz7.googlevideo.com/videoplayback?expire=1738858830&ei=7oykZ-itNNi06dsP46jjgAk&ip=176.1.196.124&id=o-ABiKYBwPJLKwNO2QYF7VdowyJSQ-VYZdL8AIn4JKq8xL&itag=140&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&bui=AY2Et-O4iQqyORFIyXKtd4NybsVxInNnpmhvcaQZumYH5qkOfNdu2oGWj-0G4u3frHPSvch-jgc6U6cb&spc=9kzgDaE8C3DCn9jIaWFRCaxfcjKNoJaLqObaoE431KV4enQhsw&vprv=1&svpuc=1&mime=audio%2Fmp4&ns=YrK54NoBn0Kj-Yqre070kq8Q&rqh=1&gir=yes&clen=2559055&dur=158.081&lmt=1707174871833082&keepalive=yes&fexp=24350590,24350737,24350827,24350934,24350961,24350976,24351028,24351059,24351082,24351092,51326932,51355912,51371294&c=WEB&sefc=1&txp=1318224&n=ev-j_xbFLUH6yw&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRgIhAJt2mceBHBmsjPRXrjEvWh-2DizL4e9a9_kIu922xvKfAiEA9ueEsafo2jSbkWh0yhFCzMNYHBwVzsJPh-y_ybU_YPM%3D&pot=MnQ6QaPTjiQdTzp9Nu28uAsVrYaFUc9y0KPa67Aa1wsnTaSUXlsDLakEk11Vf9xSLZ8eTp2HlDq9B8Ri1VQl5_6ui04C4Hb1ZAuilIL5CzrJnnmiLKLlB3iJ-ns-pb9W1jo9POCxvGw-21uTlageyirfeKAcYA==&rm=sn-uxax4vopj5qx-q0n67d,sn-4g5eye7s&rrc=79,104&req_id=1a61f698c0efa3ee&rms=rdu,au&redirect_counter=2&cms_redirect=yes&cmsv=e&ipbypass=yes&met=1738837233,&mh=CD&mip=2603:6011:4800:7400:58c5:7b32:a400:b243&mm=29&mn=sn-vgqsrnz7&ms=rdu&mt=1738837010&mv=m&mvi=2&pl=34&lsparams=ipbypass,met,mh,mip,mm,mn,ms,mv,mvi,pl,rms&lsig=AGluJ3MwRQIhAMSBX-_SONw7dIRedBj1XNe8RCZnc814_rzvQXlD6RzHAiBQH5rnUem2-CNyPE87XYe0INx2tzHKiXw_qGX7XTvoYg%3D%3D'):setAutoPlay(false)

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
    tempEnabled = 0,
    usedMarket = '',
    tableCount = -1,
    usedMarketExpires = '',
    carCollectionAmount = 0,
    carCollection = '',
    carCollectionState = ''
}

--- TIRE ARRAY KEY ---
--- 
--- NAME, AMOUNT OF SIZES, SIZE

local tireArray = {

-- BRIDGESTONE --

{'Bridgestone Potenza RE050A', 17, '205/45/R17', 400, '235/40/ZR18', 1150, '245/45/R18', 1150, '265/40/ZR18', 1500, '235/35/ZR19', 1300, '235/40/R19', 1350, '235/40/ZR19', 1300, '245/40/R19', 1300, '245/40/ZR19', 1350, '265/35/ZR19', 1650, '265/35/R19', 1450, '275/35/R19', 1500, '285/35/ZR19', 1650, '285/40/ZR19', 1700, '295/30/ZR19', 1550, '305/30/ZR19', 1800, '285/35/R20', 1750},
{'Bridgestone Potenza RE050A RFT', 9, '205/45/R17', 1050, '215/40/R18', 1500, '245/35/R18', 1200, '225/35/R19', 1500, '245/40/R19', 1700, '255/30/R19', 1550, '275/35/R19', 1800, '245/35/R20', 1350, '275/30/R20', 1750},
{'Bridgestone Potenza S001', 13, '205/45/R17', 850, '225/35/R18', 750, '225/40/R18', 650, '245/35/R18', 600, '245/40/R18', 950, '245/35/R19', 1200, '255/35/R19', 900, '215/45/R20', 1700, '245/40/R20', 1450, '245/40/ZR20', 1350, '255/35/R20', 1650, '275/30/R20', 1550, '295/35/ZR20', 2000},

-- DUNLOP --

{'Dunlop SP Sport Maxx GT600 DSST CTT NR1', 2, '255/40/ZRF20', 2050, '285/35/ZRF20', 2250},

-- MICHELIN --

{'Michelin Primacy HP', 1, '245/40/R17', 1000},
{'Michelin Pilot Sport 2', 18, '205/55/R17', 1200, '225/45/ZR17', 1050, '235/50/ZR17', 1250, '255/40/ZR17', 1500, '225/40/ZR18', 1100, '235/40/ZR18', 1050, '265/35/ZR18', 1450, '265/40/ZR18', 1550, '285/30/ZR18', 2050, '295/30/ZR18', 1950, '295/35/ZR18', 2300, '235/35/ZR19', 1450, '255/40/ZR19', 1600, '265/35/ZR19', 1700, '295/30/ZR19', 1950, '305/30/ZR19', 2100, '275/45/ZR20', 2050},
{'Michelin Pilot Sport 4', 28, '205/55/ZR16', 750, '205/40/ZR18', 1000, '215/40/R18', 1050, '225/40/ZR18', 800, '235/40/ZR18', 950, '235/45/ZR18', 1000, '245/40/ZR18', 950, '225/40/ZR19', 1100, '225/55/R19', 1100, '235/45/ZR19', 1150, '245/40/R19', 1250, '245/45/ZR19', 1350, '245/45/R19', 1300, '255/35/ZR19', 1150, '255/40/R19', 1350, '255/45/R19', 1350, '265/45/ZR19', 1500, '275/40/ZR19', 1550, '275/45/R19', 1600, '295/40/ZR19', 1550, '245/45/R20', 1350, '255/40/R20', 1600, '275/40/ZR20', 1500, '285/40/R20', 1700, '315/35/ZR20', 2500, '275/35/ZR21', 2100, '315/30/ZR21', 2500, '325/30/ZR21', 2200},
{'Michelin Pilot Super Sport', 39, '225/40/ZR18', 900, '225/45/ZR18', 1150, '245/35/ZR18', 1100, '245/40/ZR18', 1000, '255/40/ZR18', 1100, '265/40/ZR18', 1400, '275/40/ZR18', 1350, '285/35/ZR18', 1550, '295/35/ZR18', 1800, '245/35/ZR19', 1250, '255/35/ZR19', 1250, '255/45/ZR19', 1450, '265/35/ZR19', 1550, '265/40/ZR19', 1500, '275/35/ZR19', 1500, '285/30/ZR19', 1750, '285/40/ZR19', 1800, '295/35/ZR19', 1650, '305/35/ZR19', 1750, '245/35/ZR20', 1800, '245/35/R20', 1700, '245/40/ZR20', 1500, '255/40/ZR20', 1350, '265/30/ZR20', 1500, '265/35/ZR20', 1700, '275/30/R20', 1800, '275/35/ZR20', 1550, '285/30/ZR20', 1700, '295/30/ZR20', 1650, '295/35/ZR20', 1850, '305/30/ZR20', 2050, '315/35/ZR20', 2250, '335/30/ZR20', 2150, '245/35/ZR21', 1700, '285/35/ZR21', 1850, '325/30/ZR21', 2000, '275/35/ZR22', 2150, '305/30/ZR22', 2300, '305/35/ZR22', 2500},
{'Michelin Pilot Super Sport ZP', 9, '245/40/ZR18', 1300, '245/35/ZR19', 1450, '285/30/ZR19', 1900, '285/35/ZR19', 1650, '285/30/ZR20', 1800, '335/25/ZR20', 2350, '245/35/ZR21', 1900, '245/40/RF21', 2100, '275/35/RF21', 2150},

-- PIRELLI --

{'Pirelli P Zero', 96, '205/45/ZR17', 850, '205/40/ZR18', 1050, '225/40/ZR18', 750, '235/40/ZR18', 850, '235/50/ZR18', 1050, '245/35/ZR18', 950, '245/40/R18', 1050, '245/50/ZR18', 1300, '255/40/R18', 1250, '265/35/R18', 1100, '275/45/ZR18', 1500, '285/35/R18', 1200, '225/35/R19', 1200, '235/35/ZR19', 1300, '235/55/R19', 1150, '245/35/ZR19', 1450, '245/40/ZR19', 1250, '245/45/R19', 1250, '245/45/ZR19', 1400, '255/30/ZR19', 1150, '255/35/R19', 1150, '255/35/ZR19', 1450, '255/40/R19', 1350, '255/40/ZR19', 1200, '255/45/ZR19', 1550, '255/45/R19', 1450, '255/50/R19', 1400, '255/55/R19', 1150, '265/35/ZR19', 1650, '265/50/R19', 1550, '275/30/R19', 1300, '275/40/ZR19', 1600, '285/30/ZR19', 1750, '285/35/ZR19', 1500, '285/40/ZR19', 1900, '295/30/ZR19', 2000, '295/45/R19', 1800, '305/30/ZR19', 1900, '235/35/ZR20', 1400, '235/35/R20', 1450, '235/45/R20', 1250, 
'245/30/ZR20', 1850, '245/35/ZR20', 1650, '245/40/R20', 1500, '245/45/ZR20', 1300, '255/30/ZR20', 1650, '255/35/ZR20', 1250, '255/40/R20', 1450, '255/40/ZR20', 1450, '255/50/R20', 1150, '265/30/R20', 1850, '265/35/R20', 1500, '265/35/ZR20', 1700, '265/45/R20', 1700, '265/45/ZR20', 1600, '275/30/ZR20', 1750, '275/35/ZR20', 1650, '275/40/ZR20', 1350, '275/45/ZR20', 1650, '285/30/ZR20', 1700, '285/35/ZR20', 1950, '285/40/R20', 1950, '295/30/ZR20', 1750, '295/35/ZR20', 2100, '295/40/R20', 1650, '305/30/ZR20', 2200, '305/35/ZR20', 1050, '305/40/ZR20', 2300, '315/35/ZR20', 2300, '325/35/R20', 2600, '335/30/ZR20', 1300, '345/25/ZR20', 3150,
'255/30/ZR21', 1950, '255/40/R21', 1750, '265/40/ZR21', 1700, '265/40/R21', 1550, '265/45/R21', 1850, '275/30/ZR21', 2000, '275/35/ZR21', 2000, '285/30/ZR21', 2050, '285/40/ZR21', 2050, '285/45/ZR21', 2650, '295/35/ZR21', 1750, '295/35/R21', 1750, '295/40/ZR21', 1750, '315/35/ZR21', 2300, '325/25/ZR21', 2250, '355/25/ZR21', 2450, '265/40/R22', 1750, '275/40/R22', 1950, '285/35/ZR22', 2100, '285/40/ZR22', 2950, '285/40/R22', 2100, '315/30/ZR22', 2800, '325/35/R22', 2200, '335/25/ZR22', 2900},

-- VALINO --

{'Valino Greeva 08D', 8, '205/50/R15', 650, '215/40/R17', 700, '215/45/R17', 700, '235/40/R17', 700, '215/35/R18', 750, '235/40/R18', 800, '255/35/R18', 900, '265/35/R18', 950},

-- YOKOHAMA --

{'Yokohama Advan Neova AD07 LTS', 2, '175/55/R16', 750, '225/45/R17', 1000}

}

local usedMarket = {}
local usedMarketExpires = {}

local carCollectionAmount = 0
local carCollection = {}
local carCollectionState = {}

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
{'2004 Mitsubishi Lancer Evolution VIII MR GSR', 'Manual', 15000, 35000, 8, 4, 'Medium Purplish Gray Mica', 48, 'Cool Silver Metallic', 21, 'White Pearl', 24, 'Red Solid', 7},
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
--{'1995 Nissan Skyline GT-R V-Spec N1 (R33)', 'Manual', 55000, 120000, 1, 1, 'White', 1},
{'1996 Nissan Skyline GT-R (R33)', 'Manual', 35000, 90000, 7, 7, 'Super Clear Red II', 2, 'Deep Marine Blue', 3, 'Black', 7, 'Dark Grey Pearl', 2, 'Sonic Silver', 24, 'Midnight Purple', 11, 'White', 50},
--{'1996 Nissan Skyline GT-R LM-Limited (R33)', 'Manual', 70000, 140000, 2, 1, 'Champion Blue', 1},
{'1996 Nissan Skyline GT-R V-Spec (R33)', 'Manual', 40000, 90000, 5, 7, 'Super Clear Red II', 3, 'Deep Marine Blue', 3, 'Black', 7, 'Dark Grey Pearl', 3, 'Sonic Silver', 25, 'Midnight Purple', 15, 'White', 43},
--{'1996 Nissan Skyline GT-R V-Spec LM-Limited (R33)', 'Manual', 50000, 110000, 2, 1, 'Champion Blue', 1},
--{'1996 Nissan Skyline GT-R V-Spec N1 (R33)', 'Manual', 65000, 140000, 1, 1, 'White', 1},
{'1997 Nissan Skyline GT-R (R33)', 'Manual', 35000, 120000, 6, 9, 'Super Clear Red II', 2, 'Active Red', 1, 'Deep Marine Blue', 3, 'Black Pearl', 1, 'Black', 5, 'Dark Grey Pearl', 2, 'Sonic Silver', 27, 'Midnight Purple', 9, 'White', 50},
{'1997 Nissan Skyline GT-R V-Spec (R33)', 'Manual', 40000, 120000, 5, 9, 'Super Clear Red II', 3, 'Active Red', 1, 'Deep Marine Blue', 3, 'Black Pearl', 1, 'Black', 8, 'Dark Grey Pearl', 3, 'Sonic Silver', 28, 'Midnight Purple', 9, 'White', 45},
--{'1997 Nissan Skyline GT-R V-Spec N1 (R33)', 'Manual', 75000, 160000, 1, 1, 'White', 1},

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


    if carCollectionAmount > 0 then
        for i = 0, carCollectionAmount - 1 do
            --if carCollectionState [i] [0] == 'empty' then
                --carCollectionState [i] [0] = ac.getCarID(0)
            --end

        end
    end

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
            if tonumber(usedMarketExpires[i]) < tonumber(sim.systemTime) and confirmCarPurchase == false and checkListingsTimer then
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

    if loadCheckTimer + 1 > os.clock() then
        died = storedValues.died
        fuel = storedValues.fuel
        oilAmount = storedValues.oilAmount
        oilQuality = storedValues.oilQuality
        tempEnabled = storedValues.tempEnabled
        tableCount = storedValues.tableCount
        carCollectionAmount = storedValues.carCollectionAmount
        if storedValues.usedMarket ~= nil then
            usedMarket = StorageUnpackUsedMarketNested(storedValues.usedMarket, 50)
        end
        if storedValues.usedMarketExpires ~= nil then
            usedMarketExpires = StorageUnpack(storedValues.usedMarketExpires, 50, false)
        end
        carCollection = StorageUnpackCarCollectionNested(storedValues.carCollection, storedValues.carCollectionAmount)
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

local justwon = false

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
            if tableCount > 49 then
                storedValues.usedMarket = StoragePackUsedMarketNested(usedMarket)
                storedValues.usedMarketExpires = StoragePack(usedMarketExpires)
            end
            storedValues.carCollectionAmount = carCollectionAmount
            if carCollectionAmount > 0 then
                storedValues.carCollection = StoragePackCarCollectionNested(carCollection, carCollectionAmount)
            else
                storedValues.carCollection = ""
            end
            storedValues.tableCount = tableCount
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

        if math.abs(car1.acceleration.x) + math.abs(car1.acceleration.y) + math.abs(car1.acceleration.z) > 10 * safetyRating and deathDetectorSpeed > 50 + (safetyRating * 20) + (hasRollcage * 100) then
            deathPlayerChance = math.random(0,2)
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

local menuState = 21
local menuMusicsSelector = math.randomseed(sim.timeSeconds)
local transferPersonType = 0
local justtransfered = false
local usedMarketScroll = 0
local confirmCarPurchaseIndex = 1
local garageCarCycle = 0
local displayGarageCars = true
local displayGarageCarsTimer = os.clock()
local sellCarCheck = false

local rollCageCount = 0
local brakeKitCount = 0
local engineIntakeCount = 0
local engineFuelSystemCount = 0
local engineOverhaulCount = 0
local drivetrainDiffCount = 0
local driverainClutchCount = 0
local turboTurboCount = 0
local suspSwaybarCount = 0
local suspCoiloverCount = 0
local otherABSCount = 0

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
        menuMusicsSelector = math.random(0,4)
        mainMenuToggle = true
    end

    if mainMenuToggle and not ac.isKeyDown(121) then
        mainMenuToggle = false
    end

    if mainMenu == 1 then
        menu0:pause():setCurrentTime(0)
        menu1:pause():setCurrentTime(0)
        menu2:pause():setCurrentTime(0)
        menu3:pause():setCurrentTime(0)
        menu4:pause():setCurrentTime(0)
        menugtauto:pause():setCurrentTime(0)
    end

    if mainMenu == 0 and menuState == 13 then
        menugtauto:play()
    else
        menugtauto:pause():setCurrentTime(0)
    end

    if mainMenu == 0 then

        if car.speedKmh < 5 then
            --physics.setCarNoInput(true)
        end

        if menuMusicsSelector == 0 and menuState ~= 13 then
            menu0:play()
        elseif menuMusicsSelector == 1 and menuState ~= 13 then
            menu1:play()
        elseif menuMusicsSelector == 2 and menuState ~= 13 then
            menu2:play()
        elseif menuMusicsSelector == 3 and menuState ~= 13 then
            menu3:play()
        elseif menuMusicsSelector == 4 and menuState ~= 13 then
            menu4:play()
        else
            menu0:pause():setCurrentTime(0)
            menu1:pause():setCurrentTime(0)
            menu2:pause():setCurrentTime(0)
            menu3:pause():setCurrentTime(0)
            menu4:pause():setCurrentTime(0)
        end


        if  menuState == 0 then
        
            ui.toolWindow('Main Menu', vec2(0, 0), vec2(1920,1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('mainmenu', vec2(1920, 1080), false, ui.WindowFlags.None, function ()


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
                            carArrayX[i] = playerCarStates.position.x
                            carArrayZ[i] = playerCarStates.position.z
                            if carArrayX[i] ~= 0 then
                                ui.drawCircle(vec2((1920 / 2) +  carArrayX[i] / 33 + 22, (1080 / 2) +  carArrayZ[i] / 33 -50), 5, rgbm(0.6,0,1,1), 30, 15)
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
                        menuState = 4
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
                        mainMenu = mainMenu + 1
                    end


                end)


            end)
        
        elseif menuState == 1 then

            ui.toolWindow('Settings', vec2(0, 0), vec2(1920,1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('setting', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

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
                        menuState = 0
                    end


                end)


            end)

        elseif menuState == 2 then

            ui.toolWindow('Services', vec2(0, 0), vec2(1920,1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('service', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

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
                        menuState = 20
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
                        menuState = 12
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
                        menuState = 0
                    end


                end)


            end)

        elseif menuState == 3 then

            ui.toolWindow('ENGINES', vec2(0, 0), vec2(1920,1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('Engine', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

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
                        menuState = 15
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
                        menuState = 13
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
                        menuState = 0
                    end


                end)


            end)


        elseif menuState == 4 then

            ui.toolWindow('MONEYS', vec2(0, 0), vec2(1920,1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('Money', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

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
                        menuState = 11
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
                        menuState = 0
                    end


                end)


            end)

        elseif menuState == 11 then

            ui.toolWindow('TRANSFER', vec2(0, 0), vec2(1920,1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('Transfers', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

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
                    ui.textColored(ac.getDriverName(transferPersonType), rgbm(0.1,0.8,1,0.7))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 175)
                    ui.setCursorY(437 + 1)
                    ui.textColored(ac.getDriverName(transferPersonType), rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 175)
                    ui.setCursorY(437)
                    ui.textColored(ac.getDriverName(transferPersonType), rgbm(0.8,0,1,1))

                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(1080/2 + 300 + 2)
                    ui.setCursorY(405 + 2)
                    ui.dwriteTextAligned('NEXT', 50, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.5,0.5,0.5,1))

                    ui.setCursorX(1080/2 + 460)
                    ui.setCursorY(525 + 2)

                    --22

                    if transferPersonType < simstate.connectedCars - 1 then
                        if ui.invisibleButton('next', vec2(200,100)) then
                            transferPersonType = transferPersonType + 1
                        end
                    end

                    ui.setCursorX(1080/2 + 150)
                    ui.setCursorY(525 + 2)

                    if transferPersonType > 0 then
                        if ui.invisibleButton('previous', vec2(250,100)) then
                            transferPersonType = transferPersonType - 1
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
                        menuState = 4
                    end


                end)


            end)


        elseif menuState == 12 then

            ui.toolWindow('DEALERSHIP', vec2(0, 0), vec2(1920,1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('Dealership', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

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



                    ui.drawRectFilled(vec2(50,200), vec2(1400,1000), rgbm(0.8,0.8,0.8,0.9))
                    
                    ui.drawLine(vec2(1540,250), vec2(1760,250), rgbm(0.3,0.3,0.3,1), 75)
                    ui.drawLine(vec2(1540,350), vec2(1760,350), rgbm(0.3,0.3,0.3,1), 75)

                    ui.setCursorX(1576)
                    ui.setCursorY(230)
                    ui.dwriteTextAligned('SCROLL UP', 30, ui.Alignment.Start, ui.Alignment.Start, 1200, false, rgbm(0.8,0.8,0.8,1))

                    ui.setCursorX(1548)
                    ui.setCursorY(330)
                    ui.dwriteTextAligned('SCROLL DOWN', 30, ui.Alignment.Start, ui.Alignment.Start, 1200, false, rgbm(0.8,0.8,0.8,1))

                    ui.setCursorX(1539)
                    ui.setCursorY(313)

                    if ui.button('     ', vec2(221,75), ui.ButtonFlags.Repeat) and usedMarketScroll > -6700 then
                        usedMarketScroll = usedMarketScroll - 10
                    end

                    ui.setCursorX(1539)
                    ui.setCursorY(213)

                    if ui.button('    ', vec2(221,75), ui.ButtonFlags.Repeat) and usedMarketScroll < 0 then
                        usedMarketScroll = usedMarketScroll + 10
                    end
                    
                    if loadCheckTimer + 3 < os.clock() then
                        
                        for i = 1, 50 do

                        
                            if 80 + (i * 150) + usedMarketScroll > 180 and 80 + (i * 150) + usedMarketScroll < 1000 then

                                
                                ui.setCursorX(60)
                                ui.setCursorY(-515 + (i * 150) + usedMarketScroll)
                                ui.dwriteTextAligned(usedMarket[i] [0], 30, ui.Alignment.Start, ui.Alignment.Center, 1200, false, rgbm(0.5,0.2,0.2,1))
                            end

                            if 200 + (i * 150) + usedMarketScroll > 180 and 200 + (i * 150) + usedMarketScroll < 1000 then

                                ui.drawLine(vec2(50,200 + (i * 150) + usedMarketScroll), vec2(1400,200 + (i * 150) + usedMarketScroll), rgbm(0.2,0.2,0.2,0.6), 5)
                            
                            end

                            if 115 + (i * 150) + usedMarketScroll > 180 and 115 + (i * 150) + usedMarketScroll < 1000 then
                                ui.pushFont(ui.Font.Title)
                                ui.setCursorX(100)
                                ui.setCursorY(115 + (i * 150) + usedMarketScroll)
                                ui.textColored('Color: ' .. usedMarket[i] [2], rgbm(0.2,0.2,0.2,0.85))
                            end

                            if 150 + (i * 150) + usedMarketScroll > 180 and 150 + (i * 150) + usedMarketScroll < 1000 then
                                ui.pushFont(ui.Font.Title)
                                ui.setCursorX(100)
                                ui.setCursorY(150 + (i * 150) + usedMarketScroll)
                                ui.textColored('Transmission: ' .. usedMarket[i] [1], rgbm(0.2,0.2,0.2,0.85))
                            end

                            if 139 + (i * 150) + usedMarketScroll > 180 and 139 + (i * 150) + usedMarketScroll < 1000 then
                                ui.pushFont(ui.Font.Huge)
                                ui.setCursorX(800)
                                ui.setCursorY(-11 + (i * 150) + usedMarketScroll)
                                ui.dwriteTextAligned(usedMarket[i] [3] .. ' cr', 55, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.1,0.1,1))
                                ui.setCursorX(801)
                                ui.setCursorY(-10 + (i * 150) + usedMarketScroll)
                                ui.dwriteTextAligned(usedMarket[i] [3] .. ' cr', 55, ui.Alignment.End, ui.Alignment.Center, 324, false, rgbm(0.1,0.1,0.1,1))
                            end

                            if 130 + (i * 150) + usedMarketScroll > 180 and 130 + (i * 150) + usedMarketScroll < 1000  then
                                ui.drawLine(vec2(1153,153 + (i * 150) + usedMarketScroll), vec2(1383,153 + (i * 150) + usedMarketScroll), rgbm(0.1,0,0.2,0.2), 65)

                            end

                            if 130 + (i * 150) + usedMarketScroll > 180 and 130 + (i * 150) + usedMarketScroll < 1000 then
                                ui.setCursorX(1170)
                                ui.setCursorY(-450 + (i * 150) + usedMarketScroll)
                                ui.dwriteTextAligned('PURCHASE', 40, ui.Alignment.Start, ui.Alignment.Center, 1200, false, rgbm(0.4,0.1,0.8,1))

                            end

                            if 120 + (i * 150) + usedMarketScroll > 180 and 120 + (i * 150) + usedMarketScroll < 1000 then
                                ui.setCursorX(1150)
                                ui.setCursorY(120 + (i * 150) + usedMarketScroll)

                                if ui.invisibleButton('purchasecar' .. tostring(i), vec2(230,65)) then
                                    confirmCarPurchase = true
                                    confirmCarPurchaseIndex = i
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

                        if ui.invisibleButton('conformCarPurchaseYes', vec2(125,65)) and money - tonumber(usedMarket[confirmCarPurchaseIndex] [3]) > 0 then
                            checkListingsTimer = false
                            checkListingsClock = os.clock()
                            money = money - tonumber(usedMarket[confirmCarPurchaseIndex] [3])
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

                            carCollection[carCollectionAmount] = usedMarket[confirmCarPurchaseIndex]
                            carCollectionAmount = carCollectionAmount + 1
                            usedMarketExpires[confirmCarPurchaseIndex] = tostring(10)
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
                        ui.textColored(string.sub(usedMarket[confirmCarPurchaseIndex] [0], 0, 31), rgbm(0.4,0.5,1,1))
                        
                        ui.pushFont(ui.Font.Title)
                        ui.setCursorX(1520)
                        ui.setCursorY(545)
                        ui.textColored(string.sub(usedMarket[confirmCarPurchaseIndex] [0], 32, 63), rgbm(0.4,0.5,1,1))
                        
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
                        menuState = 2
                    end


                end)


            end)

        elseif menuState == 13 then

            ui.toolWindow('ENGINES', vec2(0, 0), vec2(1920,1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('Engine', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

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
                        menuState = 3
                    end


                end)


            end)


        elseif menuState == 15 then

            ui.toolWindow('CARS', vec2(0, 0), vec2(1920,1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('Cars', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

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



                    ui.drawRectFilled(vec2(250,200), vec2(1600,400), rgbm(0.2,0.2,0.2,0.9))
        
                    

                    if loadCheckTimer + 3 < os.clock() and carCollectionAmount > 0 then

                        ui.drawLine(vec2(1540,550), vec2(1760,550), rgbm(0.3,0.3,0.3,1), 75)
                        ui.drawLine(vec2(1540,650), vec2(1760,650), rgbm(0.3,0.3,0.3,1), 75)

                        ui.drawLine(vec2(780,550), vec2(1120,550), rgbm(0.2,0.2,0.2,0.9), 155)

                        if displayGarageCars then
                            ui.setCursorX(350)
                            ui.setCursorY(230)
                            ui.dwriteTextAligned(carCollection[garageCarCycle] [0], 30, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(1,1,1,1))
        
                            ui.setCursorX(336)
                            ui.setCursorY(295)
                            ui.dwriteTextAligned(carCollection[garageCarCycle] [2], 20, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(1,1,1,0.8))
        
                            ui.setCursorX(336)
                            ui.setCursorY(340)
                            ui.dwriteTextAligned(carCollection[garageCarCycle] [1], 20, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(1,1,1,0.8))
        
                            ui.setCursorX(1612)
                            ui.setCursorY(530)
                            ui.dwriteTextAligned('NEXT', 30, ui.Alignment.Start, ui.Alignment.Start, 1200, false, rgbm(0.8,0.8,0.8,1))
        
                            ui.setCursorX(1583)
                            ui.setCursorY(630)
                            ui.dwriteTextAligned('PREVIOUS', 30, ui.Alignment.Start, ui.Alignment.Start, 1200, false, rgbm(0.8,0.8,0.8,1))
        
                            ui.setCursorX(350)
                            ui.setCursorY(490)
                            ui.dwriteTextAligned('SELL', 50, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(1,0,0,1))
        
                            ui.setCursorX(350)
                            ui.setCursorY(560)
                            ui.dwriteTextAligned('(' .. math.round(carCollection[garageCarCycle] [3] / 2, 0) .. ')', 30, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(0.8,0.8,0.8,1))
        
                        end

                        ui.setCursorX(1539)
                        ui.setCursorY(513)

                        if ui.button('        ', vec2(221,75), ui.ButtonFlags.Repeat) then
                            if garageCarCycle < carCollectionAmount - 1 then
                                garageCarCycle = garageCarCycle + 1
                            else
                                garageCarCycle = 0
                            end
                        end

                        ui.setCursorX(1539)
                        ui.setCursorY(613)

                        if ui.button('       ', vec2(221,75), ui.ButtonFlags.Repeat) then
                            if garageCarCycle == 0 then
                                garageCarCycle = carCollectionAmount - 1
                            else
                                garageCarCycle = garageCarCycle - 1
                            end
                        end

                        ui.setCursorX(779)
                        ui.setCursorY(473)

                        if ui.button('         ', vec2(341,155), ui.ButtonFlags.Repeat) then
                            sellCarCheck = true
                        end

                    else
                        ui.setCursorX(350)
                        ui.setCursorY(230)
                        ui.dwriteTextAligned('NONE FOR NOW', 60, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(1,1,1,1))
        

                    end

                    if sellCarCheck then

                        ui.drawLine(vec2(780,685), vec2(1120,685), rgbm(0.2,0.2,0.2,0.9), 65)

                        ui.drawLine(vec2(780,785), vec2(920,785), rgbm(0.2,0.2,0.2,0.9), 105)
                        ui.drawLine(vec2(980,785), vec2(1120,785), rgbm(0.2,0.2,0.2,0.9), 105)

                        ui.setCursorX(350)
                        ui.setCursorY(660)
                        ui.dwriteTextAligned('ARE YOU SURE?', 35, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(1,1,1,1))

                        ui.setCursorX(250)
                        ui.setCursorY(750)
                        ui.dwriteTextAligned('YES', 50, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(1,1,1,1))
        
                        ui.setCursorX(450)
                        ui.setCursorY(750)
                        ui.dwriteTextAligned('NO', 50, ui.Alignment.Center, ui.Alignment.Start, 1200, false, rgbm(1,1,1,1))
        

                        ui.setCursorX(779)
                        ui.setCursorY(733)

                        if ui.button('          ', vec2(141,105), ui.ButtonFlags.Repeat) then
                            sellCarCheck = false
                            displayGarageCars = false
                            money = money + tonumber(math.round(carCollection[garageCarCycle] [3] / 2, 0))
                            for i = garageCarCycle + 1, carCollectionAmount - 1 do
                                carCollection[i] = carCollection[i + 1]
                            end
                            garageCarCycle = garageCarCycle - 1
                            carCollection[carCollectionAmount] = nil
                            carCollectionAmount = carCollectionAmount - 1
                            displayGarageCarsTimer = os.clock()
                        end

                        ui.setCursorX(979)
                        ui.setCursorY(733)

                        if ui.button('           ', vec2(141,105), ui.ButtonFlags.Repeat) then
                            sellCarCheck = false
                        end
                    end

                    
                    if not displayGarageCars and displayGarageCarsTimer + 0.01 < os.clock() then
                        garageCarCycle = 0
                        displayGarageCars = true
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
                        menuState = 3
                    end


                end)


            end)

        elseif menuState == 20 then

            ui.toolWindow('TUNING SHOP', vec2(0, 0), vec2(1920,1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('TuningShop', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

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
                        ui.dwriteTextAligned(carCollection[garageCarCycle][0], 32, ui.Alignment.Center, ui.Alignment.Center, 1224, false, rgbm(1,0.2,0.1,1))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(475)
                        ui.setCursorY(265)
                        ui.dwriteTextAligned(carCollection[garageCarCycle][2], 23, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.8,0.8,0.8,1))

                        ui.pushFont(ui.Font.Huge)
                        ui.setCursorX(475)
                        ui.setCursorY(305)
                        ui.dwriteTextAligned(carCollection[garageCarCycle][1], 23, ui.Alignment.Start, ui.Alignment.Center, 1224, false, rgbm(0.8,0.8,0.8,1))

                        ui.setCursorX(120)
                        ui.setCursorY(870)

                        if ui.button('PREV.', vec2(180,80)) then
                            if garageCarCycle == 0 then
                                garageCarCycle = carCollectionAmount - 1
                            else
                                garageCarCycle = garageCarCycle - 1
                            end
                        end

                        ui.setCursorX(1200)
                        ui.setCursorY(870)

                        if ui.button('NEXT', vec2(180,80)) then
                            if garageCarCycle < carCollectionAmount - 1 then
                                garageCarCycle = garageCarCycle + 1
                            else
                                garageCarCycle = 0
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
                        menuState = 21
                    end

                    ui.setCursorX(520)
                    ui.setCursorY(235)

                    if ui.button('  ', vec2(160,140)) then
                        menuState = 22
                    end

                    ui.setCursorX(920)
                    ui.setCursorY(235)

                    if ui.button('   ', vec2(160,140)) then
                        menuState = 23
                    end

                    ui.setCursorX(1320)
                    ui.setCursorY(235)

                    if ui.button('    ', vec2(160,140)) then
                        menuState = 24
                    end

                    ui.setCursorX(120)
                    ui.setCursorY(485)

                    if ui.button('     ', vec2(160,140)) then
                        menuState = 25
                    end

                    ui.setCursorX(520)
                    ui.setCursorY(485)

                    if ui.button('      ', vec2(160,140)) then
                        menuState = 26
                    end

                    ui.setCursorX(920)
                    ui.setCursorY(485)

                    if ui.button('       ', vec2(160,140)) then
                        menuState = 27
                    end

                    ui.setCursorX(1320)
                    ui.setCursorY(485)

                    if ui.button('        ', vec2(160,140)) then
                        menuState = 28
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
                        menuState = 2
                    end


                end)


            end)


        elseif menuState == 21 then

            ui.toolWindow('BODY TUNING SHOP', vec2(0, 0), vec2(1920,1080), function ()

                ui.pushFont(ui.Font.Huge)
                ui.childWindow('BodyTuningShop', vec2(1920, 1080), false, ui.WindowFlags.None, function ()

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


                    ui.pushFont(ui.Font.Huge)
                    ui.setCursorX(90)
                    ui.setCursorY(90)
                    ui.dwriteTextAligned('Roll Cage', 35, ui.Alignment.Center, ui.Alignment.Center, 324, false, rgbm(0.8,0.8,0.8,1))

                    
                    if ui.button('next ', vec2(90,50)) then
                        if rollCageCount ~= 2 then
                            rollCageCount = rollCageCount + 1
                        else
                            rollCageCount = 0
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
                        menuState = 20
                    end


                end)


            end)


        end
    else
        --physics.setCarNoInput(false)

    end

    if mainMenu == 1 and tempEnabled == 1 then

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
        
        mainMenu = 1
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
            if deathPlayerChance == 0 then
                deathSound0:play()
            elseif deathPlayerChance == 1 then
                deathSound1:play()
            elseif deathPlayerChance == 2 then
                deathSound2:play()
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

    transferMoney{ person = ac.getDriverName(transferPersonType), money = moneyTransfer }

end
