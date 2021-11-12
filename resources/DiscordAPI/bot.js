const Discord = require('discord.js');
var client = new Discord.Client;
const config = require('./config.json');
var CurrentChannel = false;
var RefreshBot = false;
var ancienName = false;
var dt = new Date()

StartBot = () => {
     client.on('ready', () => {
          console.log('[^3DiscordAPI^7] Callback received')
          console.log('[^4Authentic^7] Action réussi !')
          // client.channels.get(config.channel_statsadmin).send(SendEmbed({
          //      title: "ModernRoleplay - BOT",
          //      description: '`☂️ Serveur ON !`',
          //      color : "#1bd411",
          //      author: "Console",
          //      footer: "Informations du Bot de ModernRoleplay → Aujourd'hui à "+ dt.getHours() +':'+ dt.getMinutes()
          // }))
          exports['DiscordAPI'].GetConfig(config);
     })

     client.on('message', msg => {
          CurrentChannel = msg.channel;
          var embed = new Discord.MessageEmbed()
          if (msg.content.startsWith(config.prefix)) {
               var args = msg.content.substring().split(" ");
               if (msg.member.roles.find((search) => search.id == config.admin_roleid)) {
                    if (args[0] == config.prefix + 'pulsion') {
                         if (args[1] && args[2]) {
                              return exports['DiscordAPI'].AddPulsion(msg.author.username, args[1], args[2]);
                         }else {
                              embed
                              .setColor('#6800d6')
                              .setTitle('Voici un exemple : !pulsion `discord` `points`')
                              .setAuthor(msg.author.username)
                              .setTimestamp()
                              .setThumbnail("https://cdn.discordapp.com/attachments/869358996862144572/897940086707060796/ezgif.com-gif-maker25.png")
                              msg.channel.send(embed)
                              return false;
                         }
                    }else if (args[0] == config.prefix + 'inventaire') {
                         if (args[1]) {
                              return exports['DiscordAPI'].GetInventory(msg.author.username, args[1]);
                         }else {
                              embed
                              .setColor('#6800d6')
                              .setTitle('Voici un exemple : !inventory `id` or `identifier`')
                              .setAuthor('Usage de la commande incorrecte.')
                              .setFooter('Informations inventaire du joueur. • Aujourd\'hui à '+ dt.getHours() +':'+ dt.getMinutes())
                              .setThumbnail("https://cdn.discordapp.com/attachments/869358996862144572/897940086707060796/ezgif.com-gif-maker25.png")
                              msg.channel.send(embed)
                              return false;
                         }
                    }else if (args[0] == config.prefix + 'info') {
                         if (args[1]) {
                              return exports['DiscordAPI'].GetGeneralInformations(msg.author.username, args[1]);
                         }else {
                              embed
                              .setColor('#6800d6')
                              .setTitle('Voici un exemple : !playerinfo `identifier` or `id`')
                              .setAuthor('Usage de la commande incorrecte.')
                              .setFooter('Informations sur les info d\'un joueur. • Aujourd\'hui à '+ dt.getHours() +':'+ dt.getMinutes())
                              .setThumbnail("https://cdn.discordapp.com/attachments/869358996862144572/897940086707060796/ezgif.com-gif-maker25.png")
                              msg.channel.send(embed)
                              return false;
                         }
                    }else if (args[0] == config.prefix + 'revive') {
                         if (args[1]) {
                              return exports['DiscordAPI'].Revive(msg.author.username, args[1]);
                         }else {
                              embed
                              .setColor('#6800d6')
                              .setTitle('Voici un exemple : !revive `id`')
                              .setAuthor('Usage de la commande incorrecte.')
                              .setFooter('Informations sur revive d\'un joueur. • Aujourd\'hui à '+ dt.getHours() +':'+ dt.getMinutes())
                              .setThumbnail("https://cdn.discordapp.com/attachments/869358996862144572/897940086707060796/ezgif.com-gif-maker25.png")
                              msg.channel.send(embed)
                              return false;
                         }
                    }else if (args[0] == config.prefix + 'reviveall') {
                         return exports['DiscordAPI'].ReviveAll(msg.author.username);
                    }else if (args[0] == config.prefix + 'car') {
                         if (args[1] && args[2]) {
                              return exports['DiscordAPI'].SpawnVehicle(msg.author.username, args[1], args[2]);
                         }else{
                              embed
                              .setColor('#6800d6')
                              .setTitle('Voici un exemple : !car `id` `vehicle`')
                              .setAuthor('Usage de la commande incorrecte.')
                              .setFooter('Informations spawn vehicle. • Aujourd\'hui à '+ dt.getHours() +':'+ dt.getMinutes())
                              .setThumbnail("https://cdn.discordapp.com/attachments/869358996862144572/897940086707060796/ezgif.com-gif-maker25.png")
                              msg.channel.send(embed)
                              return false;
                         }
                         
                    }else if (args[0] == config.prefix + 'help') {
                         embed.setColor('#6800d6')
                         .addField('`☂️`  __Prefix du Bot__ : **'+config.prefix+"**", '`🔨` - **© Credits : Created by Authentic.**', false)
                         .addField('Toutes les commandes disponible : ', '⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃', false)
                         .addField('Commandes : (`inventaire`)', '**Voir l\'inventaire d\'un joueur**', true)
                         .addField('Commandes : (`info`)', '**Voir les informations d\'un joueur**', true)
                         .addField('Commandes : (`players`)', '**Voir tout les joueurs en lignes.**', true)
                         .addField('Commandes : (`pulsion`)', '**Ajouter des point boutique (F1) à un joueur**', true)
                         .addField('Commandes : (`revive`)', '**Réanimer un joueur**', true)
                         .addField('Commandes : (`reviveall`)', '**Réanimer tout les joueurs du serveur**', true)
                         .addField('Commandes : (`clear`)', '**Supprime tout les message d\'un channel**', true)
                         .addField('Commandes : (`lock`)', '**Bloque l\'accès au message pour les citoyens**', true)
                         .addField('Commandes : (`unlock`)', '**Débloque l\'accès au message pour les citoyens**', true)
                         .addField('Commandes : (`ban`)', '**Bannire un citoyen de nos services**', true)
                         .addField('Commandes : (`unban`)', '**Débannire un citoyen de nos services**', true)
                         .addField('Commandes : (`setgroup`)', '**Changer le grade d\'un joueur sur notre service FiveM**', true)
                         .addField('Commandes : (`demote`)', '**Viré un staff de notre service FiveM**', true)
                         .setColor("RANDOM")
                         .setTimestamp()
                         .setThumbnail(msg.author.displayAvatarURL())
                         msg.channel.send(embed);
                         return false;
                    }else if (args[0] == config.prefix + 'lock') {
                         const role2 = msg.guild.roles.find(role => role.id === '818497591221551118') 
                         msg.channel.updateOverwrite(role2,{ 'SEND_MESSAGES': false}) 
                         embed
                         .setColor('#ff0000')
                         .setTitle(msg.author.username+' vient de lock le channel #'+ msg.channel.name +" avec succès !")
                         .setAuthor(msg.author.username)
                         .setFooter(msg.guild.name+'  •  Infomations sur channel '+ msg.channel.name +'')
                         .setThumbnail(msg.guild.iconURL())
                         msg.channel.send(embed)
                         ancienName = msg.channel.name;
                         msg.channel.setName("🔒-"+msg.channel.name)
                         // console.log(ancienName)
                    }else if (args[0] == config.prefix + 'unlock') {
                         const role2 = msg.guild.roles.find(role => role.id === '818497591221551118') 
                         msg.channel.updateOverwrite(role2,{ 'SEND_MESSAGES': true}) 
                         embed
                         .setColor('#1bd411')
                         .setTitle(msg.author.username+' vient de unlock le channel #'+ msg.channel.name +" avec succès !")
                         .setAuthor(msg.author.username)
                         .setFooter(msg.guild.name+'  •  Infomations sur channel '+ msg.channel.name +'')
                         .setThumbnail(msg.guild.iconURL())
                         msg.channel.send(embed)
                         if (ancienName != false) {
                              msg.channel.setName(ancienName)
                         }
                    }else if (args[0] == config.prefix + 'clear') {
                         msg.channel.bulkDelete(100)
                         setTimeout(300, function() {
                              msg.channel.bulkDelete(100)
                         })
                         setTimeout(300, function() {
                              msg.channel.bulkDelete(100)
                              })
                              setTimeout(300, function() {
                              msg.channel.bulkDelete(100)
                              })
                              setTimeout(300, function() {
                              msg.channel.bulkDelete(100)
                              })
                              setTimeout(300, function() {
                              msg.channel.bulkDelete(100)
                              })
                         embed
                         .setColor('RANDOM')
                         .setTitle("Clear effectué !")
                         .setAuthor(msg.author.username)
                         .setTimestamp()
                         .setThumbnail("https://cdn.discordapp.com/attachments/869358996862144572/897940086707060796/ezgif.com-gif-maker25.png")
                         msg.channel.send(embed).then((msg) => msg.delete(5000));
                    }else if (args[0] == config.prefix + 'unban') {
                         if (args[1]) {
                              msg.guild.members.unban(args[1])
                              embed
                              .setColor('RANDOM')
                              .setTitle(`Utilisateur débanni avec succès de ${msg.guild.name} et de tout nos services, merci !`)
                              .setAuthor(msg.author.username)
                              .setTimestamp()
                              .setThumbnail(msg.guild.iconURL())
                              msg.channel.send(embed)
                              exports['DiscordAPI'].UnbanAll(msg.author.username, args[1]);
                         }else{
                              embed
                              .setColor('#FF000')
                              .setTitle('Argument manquant pour la commande `unban` !')
                              .setAuthor(msg.author.username)
                              .setTimestamp()
                              .setThumbnail(msg.author.avatarURL())
                              msg.channel.send(embed)
                         }
                    }else if (args[0] == config.prefix + 'ban') {
                         if (args[1] && args[2]) {
                              embed
                              .setColor('RANDOM')
                              .setTitle(`Utilisateur banni avec succès de ${msg.guild.name} et de tout nos services, merci !`)
                              .setAuthor(msg.author.username)
                              .setTimestamp()
                              .setThumbnail(msg.guild.iconURL())
                              msg.channel.send(embed)
                              msg.guild.members.ban(args[1], args[2])
                              exports['DiscordAPI'].BanAll(msg.author.username, args[1], args[2]);
                         }else{
                              embed
                              .setColor('#FF000')
                              .setTitle('Argument manquant pour la commande `ban` !')
                              .setAuthor(msg.author.username)
                              .setTimestamp()
                              .setThumbnail(msg.author.avatarURL())
                              msg.channel.send(embed)
                         }
                    }else if (args[0] == config.prefix + 'setgroup') {
                         if (args[1] && args[2] && args[3]) {
                              return exports['DiscordAPI'].SetGroup(msg.author.username, args[1], args[2], args[3])
                         }else{
                              embed
                              .setColor('#FF000')
                              .setTitle('Argument manquant pour la commande `setgroup` `id` `group` `permission` !')
                              .setAuthor(msg.author.username)
                              .setTimestamp()
                              .setThumbnail(msg.author.avatarURL())
                              msg.channel.send(embed)
                         }
                    }else if (args[0] == config.prefix + 'demote') {
                         if (args[1]) {
                              return exports['DiscordAPI'].Demote(msg.author.username, args[1])
                         }else{
                              embed
                              .setColor('#FF000')
                              .setTitle('Argument manquant pour la commande `demote` `id` !')
                              .setAuthor(msg.author.username)
                              .setTimestamp()
                              .setThumbnail(msg.author.avatarURL())
                              msg.channel.send(embed)
                         }
                    }else if (args[0] == config.prefix + 'refresh') {
                         msg.channel.send(SendEmbed({
                              title: "ModernRoleplay - BOT",
                              description: '`☂️ Bot redémarré !`',
                              color : "#1bd411",
                              author: msg.author.username,
                              footer: "Informations du Bot de ModerRoleplay • Aujourd'hui à "+ dt.getHours() +":"+ dt.getMinutes()
                         }))
                         console.log("^3Bot refreshed^7")
                    }
               }else {
                    embed
                    .setColor('#ff0000')
                    .setDescription('Vous n\'avez pas les permissions de faire ceci !')
                    .setAuthor('Avertissement')
                    msg.channel.send(embed)
                    return false;
               }
          }
     })
     client.login(config.token)
}

RegisterNetEvent('DiscordAPI:SendEmbed')
on('DiscordAPI:SendEmbed', embed => {
     (CurrentChannel && CurrentChannel.send(SendEmbed(embed)))
     if (embed.description) {
          if (embed.title) {
               client.channels.get(config.log_channel).send(SendEmbed({
                    title: "*"+ embed.title + "*",
                    description: '`☂️ '+ embed.description +'`',
                    color : "RANDOM",
                    author: "Logs • Aujourd'hui à "+ dt.getHours() +":"+ dt.getMinutes(),
                    footer: "Demandé par "+ embed.author,
                    thumbnail: "https://cdn.discordapp.com/attachments/898260829512826952/898265701905739797/12cad38891f149df1a4d60eda18d652a.png"
               }))
          }
          else{
               client.channels.get(config.log_channel).send(SendEmbed({
                    title: "Aucun titre",
                    color : "RANDOM",
                    description: '`☂️ '+ embed.description +'`',
                    author: new Date(),
                    footer: "Demandé par "+ embed.author+" • Aujourd'hui à "+ dt.getHours() +":"+ dt.getMinutes(),
                    thumbnail: "https://cdn.discordapp.com/attachments/898260829512826952/898265701905739797/12cad38891f149df1a4d60eda18d652a.png"
               }))
          }
     }else {
          client.channels.get(config.log_channel).send(SendEmbed({
               title: "*"+ embed.title + "*",
               color : "RANDOM",
               author: new Date(),
               footer: "Demandé par "+ embed.author+" • Aujourd'hui à "+ dt.getHours() +":"+ dt.getMinutes(),
               thumbnail: "https://cdn.discordapp.com/attachments/898260829512826952/898265701905739797/12cad38891f149df1a4d60eda18d652a.png"
          }))
     }
});

SendEmbed = (embed) => {
     var CreateEmbed = new Discord.MessageEmbed()
     embed.footer && CreateEmbed.setFooter(embed.footer)
     embed.thumbnail && CreateEmbed.setThumbnail(embed.thumbnail)
     embed.description && CreateEmbed.setDescription(embed.description)
     embed.author && CreateEmbed.setAuthor(embed.author)
     embed.color && CreateEmbed.setColor(embed.color)
     embed.title && CreateEmbed.setTitle(embed.title)
     if (embed.fields) {
          for (x in embed.fields) {
               CreateEmbed.addField(embed.fields[x].name, embed.fields[x].value, embed.fields[x].inline || false)
          }
     }
     return CreateEmbed
}

StartBot();
