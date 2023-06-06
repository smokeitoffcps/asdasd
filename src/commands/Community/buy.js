const { SlashCommandBuilder } = require('@discordjs/builders');
const { EmbedBuilder } = require('discord.js');
const fs = require('fs');
let isCommandRunning = false;

module.exports = {
  data: new SlashCommandBuilder()
    .setName('purchase')
    .setDescription('Purchase script')
    .addStringOption((option) =>
      option
        .setName('script')
        .setDescription('The script to purchase')
        .setRequired(true)
        .addChoices(
          { name: 'PTHT', value: 'ptht' },
         // { name: 'Example', value: 'example' }
        )
    ),

  async execute(interaction) {
    if (isCommandRunning) {
      await interaction.reply('Sorry, someone else is currently using the command. Please try again later.');
      return;
    }
    isCommandRunning = true;

    const script = interaction.options.getString('script');
    const world = interaction.options.getString('world');
    let roleId;
    let amount;

    switch (script) {
      case 'ptht':
        roleId = '';
        amount = 15; // bgl amount
        break;
       // case 'example':
       // roleId = '';
       // amount = 15; // bgl amount
       // break;
      default:
        await interaction.reply('Invalid script provided.');
        isCommandRunning = false;
        return;
    }

    const confirmationFile = 'C:/Cobalt/confirmation.txt';
    const logFile = 'C:/Cobalt/purchase_logs.txt';

    const embed = new EmbedBuilder()
      .setColor('#2f3136')
      .setTitle('Script Buying Instructions')
      .setDescription(`1. Go to world "**AUTOPURCHASESCRIPT**"\n2. Trade bot named "**@ggobfuscator**"\n3. Place the amount of \`${amount}\` Blue Gem Locks (only put Blue Gem Locks to the trade)\n4. Accept the trade`)
      .setTimestamp();
    
    await interaction.reply({ embeds: [embed] });

    fs.appendFileSync(logFile, `${amount}\n\n`);

    const interval = setInterval(() => {
      if (fs.existsSync(confirmationFile)) {
        const confirmationText = fs.readFileSync(confirmationFile, 'utf8');
    
        if (confirmationText.trim().toLowerCase() === 'confirmed') {
          const user = interaction.member;
    
          user.roles.add(roleId);
          fs.unlinkSync(confirmationFile);
    
          const successEmbed = new EmbedBuilder()
            .setColor('#2f3136')
            .setTitle('Script Bought Succesfully')
            .setDescription('Role assigned successfully!');
    
          interaction.followUp({ embeds: [successEmbed] });
    
          isCommandRunning = false;
          clearInterval(interval);
        }
      }
    }, 10000);

        timeout = setTimeout(() => {
          isCommandRunning = false;
          clearInterval(interval);
          interaction.followUp('Timeout: Command reset. Please try again later.');
        }, 300000); // Time is in milliseconds
  },
};
