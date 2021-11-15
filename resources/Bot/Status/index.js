const {Client, Collection, Intents, MessageEmbed,MessageAttachment} = require("discord.js");
const {token, prefix} = require("./sensible");
const {server, support, fivemStatus, statues, timeDeleteMessage} = require("./config");
const {readdirSync} = require("fs");
const {query} = require("gamedig")

const client = new Client({ intents: [Intents.FLAGS.GUILDS] });
require("discord-buttons")(client)

client.db =  require("./db.json");
client.commands = new Collection();
client.functions = new Collection();

const loadCommands = (dir = "./commands/") => {
	readdirSync(dir).forEach(dirs => {
		const commands = readdirSync(`${dir}/${dirs}/`).filter(files => files.endsWith(".js"));

		for (const file of commands) {
			const getFileName = require(`${dir}/${dirs}/${file}`);
			client.commands.set(getFileName.help.name, getFileName);
			console.log(`Commande chargée : ${getFileName.help.name}`)
		};
	});
};

const loadFunctions = (dir = "./functions") => {
	readdirSync(dir).forEach(dirs => {
		const functions = readdirSync(`${dir}`).filter(files => files.endsWith(".js"));

		for (const file of functions) {
			const getFileName = require(`${dir}/${file}`);
			client.functions.set(getFileName.name, getFileName);
		};
	});
};

loadCommands();
loadFunctions();

const executeFunction = function(name, ...rest) {
	const selectFunction = client.functions.get(name);
	if (!selectFunction) return console.log(`Commande '${name}' invalide !`);
	selectFunction.start(...rest)
}

client.on("ready", () => {
	console.log(`Je me suis connecté en tant que ${client.user.tag}`)

	setInterval(function() {

		if (client.guilds.cache.size > 2) {
			client.guilds.cache.forEach(guild => {
				if (guild != server.serverId) {
					guild.leave()
					console.log(`Je part du serveur <${guild}> !`)
					return
				}
			})
		}

		executeFunction("fivemStatus", client, fivemStatus.channels.connect, fivemStatus.messages.announce)

		let status = statues[Math.floor(Math.random()*statues.length)];
		if (status == "players") {
			let ip = fivemStatus.liens.ip
			return query({
				type: 'fivem',
				host: ip[0],
				port: ip[1],
				socketTimeout: 15000,
				udpTimeout: 15000
			}).then((info) => {
				playersCount = Number(info.raw.clients) 
				client.user.setPresence({ activity: { name: playersCount + " / 512 en ligne .", type:"WATCHING"}, status: 'online'})
			}).catch((error) => {
				client.user.setPresence({ activity: { name: "😨 Serveur hors-ligne", type:"WATCHING"}, status: 'online'})
			})
		} else {
			client.user.setPresence({activity: {name:status}, status: 'online'})
		}
	}, 5600)
});

client.login(token);
