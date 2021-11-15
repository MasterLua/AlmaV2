const { MessageButton } = require('discord-buttons');
const moment = require("moment")
const Discord = require('discord.js');
const { query } = require("gamedig")
const { fivemStatus, server } = require("../config")
let number = 1;

function makeid(length) {
    var result = '';
    var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for (var i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() *
            charactersLength));
    }
    return result;
}


// Model de code pour embed //
// const Buttonze = new MessageButton()
//     .setStyle('url')
//     .setURL("https://shop-almarp.tebex.io")
//     .setLabel("Notre boutique")
//     .setEmoji('💰')
// const Buttonzes = new MessageButton()
//     .setStyle('url')
//     .setURL("https://forum.cfx.re/sign")
//     .setLabel("Création d'un compte")
//     .setEmoji('🐌')
// const Buttonzess = new MessageButton()
//     .setStyle('url')
//     .setURL("https://forum.cfx.re/login")
//     .setLabel("Se connecter")
//     .setEmoji('🐌')
// embed
//     .setColor('#ffc02c')
//     .setAuthor("💰 Donation / Boutique")
//     .setDescription("[Voici un tuto pour relier votre compte à FiveM](https://www.youtube.com/watch?v=-g5l_m2rk1Y)")
//     .addField("🐲 Boutique Alma V2", "```💳 Carte bancaire et Paypal``````🔎 Autres moyen de paiements ?, Contacter un fondateur```", false)
//     .addField("😨 Avant tout achat", "```🐌 N'oubliez pas de liez votre compte CFX.RE à votre FiveM afin de recevoir vos points.```", true)
//     .setFooter('Communauté datant de 2020, en pleine expension !')
//     .setImage("https://cdn.discordapp.com/attachments/909416110091284541/909470866310565918/image12.png")
// client.channels.cache.get("908793491813978182").send(embed, { buttons: [Buttonze, Buttonzes, Buttonzess] })

module.exports.name = "fivemStatus"
module.exports.start = async (client, channelId, messageId) => {
    const channel = client.channels.cache.get(channelId)
    channel.messages.fetch(messageId).then(message => {
        if (!message) return;

        let ip = fivemStatus.liens.ip
        let boutique = fivemStatus.liens.boutique
        let cfx = fivemStatus.liens.cfx
        var embed = new Discord.MessageEmbed()

        const guild = client.guilds.cache.get(server.serverId)
        const channelAnnounce = guild.channels.cache.get(fivemStatus.channels.announce)

        if (!channelAnnounce) return;
        return query({
            type: 'fivem',
            host: ip[0],
            port: ip[1],
            socketTimeout: 15000,
            udpTimeout: 15000
        }).then((info) => {
            playersMax = info.raw.sv_maxclients
            playersCount = Number(info.raw.clients)
            id = makeid(6)
            if (number == 1) {
                number = 2
            }else if (number == 2) {
                number = 1
            }
            console.log("\n[" + id +"] | [Authentic-Status] " + playersCount + " / " + playersMax + " En ligne\n")
            var currentdate = new Date();
            moment.locale('fr')
            const Button1 = new MessageButton()
                .setStyle('url')
                .setURL(cfx[0])
                .setLabel("Rejoindre l'aventure")
                .setEmoji('🐲')
            if (number == 1) {
                embed
                .setColor('#ffc02c')
                .setAuthor("🐲 AlmaRP [" + id +"]")
                .setDescription("\n```1er Option : Chercher → AlmaRP dans la liste FiveM``````2e Option : Utiliser le boutton de connexion ci-dessous```")
                .addField("Status du serveur :", "```Ouvert à tout le monde, vous pouvez vous connecté 👊🏽```", true)
                .addField("Joueurs en ligne :", "```" + playersCount + " / " + playersMax + " en ligne 🐲```", true)
                .setFooter('🐲 AlmaRP • Aujourd\'hui à ' + currentdate.getHours() + ':' + currentdate.getMinutes() + ' et ' + currentdate.getSeconds() + ' secondes')
                .setImage("https://cdn.discordapp.com/attachments/909416110091284541/909470866310565918/image12.png")
            } else if (number == 2) {
                embed
                .setColor('#ffc02c')
                .setAuthor("🐲 AlmaStatus [" + id +"]")
                .setDescription("\n```1er Option : Chercher → AlmaRP dans la liste FiveM``````2e Option : Utiliser le boutton de connexion ci-dessous```")
                .addField("Status du serveur :", "```Ouvert à tout le monde, vous pouvez vous connecté 👊🏽```", true)
                .addField("Joueurs en ligne :", "```" + playersCount + " / " + playersMax + " en ligne 🐲```", true)
                .setFooter('🐲 AlmaStatus • Aujourd\'hui à ' + currentdate.getHours() + ':' + currentdate.getMinutes() + ' et ' + currentdate.getSeconds() + ' secondes')
                .setImage("https://cdn.discordapp.com/attachments/909416110091284541/909470866310565918/image12.png")
            }
            message.edit(embed, {buttons: [Button1]})
        }).catch((error) => {
            console.log("\n[Authentic-Status] Anormal Response, wait any response.\n")

            var currentdate = new Date();
            const Button1 = new MessageButton()
            .setStyle('url')
            .setURL(cfx[0]) 
            .setLabel("Serveur inaccessible")
            .setEmoji('✖️')

            // const Button2 = new MessageButton()
            // .setStyle('url')
            // .setURL(boutique) 
            // .setLabel("Boutique")
            // .setEmoji('⭐')
            embed
                .setColor('#ffc02c')
                .setAuthor('😥 Serveur hors-ligne')
                .setDescription("\n```1er Option : Chercher → AlmaRP dans la liste FiveM``````2e Option : Utiliser le boutton de connexion ci-dessous```")
                .addField("Status du serveur :", "```Réponse anormale, vous ne pouvez vous connecté au serveur ✖️```", true)
                .setFooter('🐲 Anormal Response • Aujourd\'hui à ' + currentdate.getHours() + ':' + currentdate.getMinutes() + ' et ' + currentdate.getSeconds() + ' secondes')
                .setImage("https://cdn.discordapp.com/attachments/909416110091284541/909470866310565918/image12.png")
            moment.locale('fr')
            message.edit(embed, {buttons: [Button1]})
        })
    })
}
