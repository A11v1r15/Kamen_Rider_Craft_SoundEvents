StringList footsoldierList = new StringList();
StringList bossList = new StringList();
StringList allyList = new StringList();
StringList mobList = new StringList();
StringDict constants = new StringDict();
StringDict identifiers = new StringDict();
String footsoldierMixin;
String bossMixin;
String allyMixin;

void setup() {
  String[] mobsCore = loadStrings("../../../../Kamen_Rider_Craft/src/main/java/com/kelco/kamenridercraft/entity/mobs/MobsCore.java");
  for (String line : mobsCore) {
    if (line.contains("DeferredHolder<EntityType<?>")) {
      try {
        String k = match(line, "\\?>, EntityType<(.*?)>>")[1];
        String c = match(line, ">> (.*?) = MOBLIST")[1];
        String i = match(line, "MOBLIST.register(.*?),")[1];
        i = i.substring(2, i.length() - 1);
        constants.set(k, c);
        identifiers.set(k, i);
      }
      catch(NullPointerException e) {
        println(line);
      }
    }
  }
  footsoldierList.append(loadStrings("footsoldiers.txt"));
  bossList.append(loadStrings("bosses.txt"));
  allyList.append(loadStrings("allies.txt"));
  mobList.append(footsoldierList);
  mobList.append(bossList);
  mobList.append(allyList);
  mobList.sort();
  footsoldierMixin = String.join("\n", loadStrings("../../../src/main/java/net/a11v1r15/kamenridercraftsoundevents/mixin/foot_soldiers/AbaddonEntityMixin.java"));
  bossMixin = footsoldierMixin
    .replace("package net.a11v1r15.kamenridercraftsoundevents.mixin.foot_soldiers;", "package net.a11v1r15.kamenridercraftsoundevents.mixin.bosses;")
    .replace("import com.kelco.kamenridercraft.entity.mobs.foot_soldiers.AbaddonEntity;", "import com.kelco.kamenridercraft.entity.mobs.bosses.AbaddonEntity;");
  allyMixin = String.join("\n", loadStrings("../../../src/main/java/net/a11v1r15/kamenridercraftsoundevents/mixin/allies/AnkhEntityMixin.java"));

  String referenceFootsoldier = "AbaddonEntity";
  String referenceFootsoldierName = referenceFootsoldier.substring(0, referenceFootsoldier.length() - 6);
  String referenceAlly = "AnkhEntity";
  String referenceAllyName = referenceAlly.substring(0, referenceAlly.length() - 6);

  String KamenRiderCraftSoundEvents = "";

  JSONObject mixins_json = loadJSONObject("kamenridercraftsoundevents.mixins.json");
  JSONObject sounds_json = loadJSONObject("sounds.json");
  JSONObject lang_en_us = loadJSONObject("lang/en_us.json");
  JSONObject lang_ja_jp = loadJSONObject("lang/ja_jp.json");
  JSONObject lang_zh_cn = loadJSONObject("lang/zh_cn.json");
  JSONObject origin_lang_en_us = loadJSONObject("../../../../Kamen_Rider_Craft/src/main/resources/assets/kamenridercraft/lang/en_us.json");
  JSONObject origin_lang_ja_jp = loadJSONObject("../../../../Kamen_Rider_Craft/src/main/resources/assets/kamenridercraft/lang/ja_jp.json");
  JSONObject origin_lang_zh_cn = loadJSONObject("../../../../Kamen_Rider_Craft/src/main/resources/assets/kamenridercraft/lang/zh_cn.json");

  JSONArray mixins_jsonMixins = mixins_json.getJSONArray("mixins");

  JSONArray sounds_jsonAmbientEnemy = new JSONArray();
  sounds_jsonAmbientEnemy.append("mob/pillager/idle1");
  sounds_jsonAmbientEnemy.append("mob/pillager/idle2");
  sounds_jsonAmbientEnemy.append("mob/pillager/idle3");
  sounds_jsonAmbientEnemy.append("mob/pillager/idle4");
  JSONArray sounds_jsonDeathEnemy = new JSONArray();
  sounds_jsonDeathEnemy.append("mob/pillager/death1");
  sounds_jsonDeathEnemy.append("mob/pillager/death2");
  JSONArray sounds_jsonHurtEnemy = new JSONArray();
  sounds_jsonHurtEnemy.append("mob/pillager/hurt1");
  sounds_jsonHurtEnemy.append("mob/pillager/hurt2");
  sounds_jsonHurtEnemy.append("mob/pillager/hurt3");
  JSONArray sounds_jsonShootEnemy = new JSONArray();
  sounds_jsonShootEnemy.append("mob/ghast/fireball4");
  
  JSONArray sounds_jsonAmbientAlly = new JSONArray();
  sounds_jsonAmbientAlly.append("mob/villager/idle1");
  sounds_jsonAmbientAlly.append("mob/villager/idle2");
  sounds_jsonAmbientAlly.append("mob/villager/idle3");
  JSONArray sounds_jsonDeathAlly = new JSONArray();
  sounds_jsonDeathAlly.append("mob/villager/death");
  JSONArray sounds_jsonHurtAlly = new JSONArray();
  sounds_jsonHurtAlly.append("mob/villager/hit1");
  sounds_jsonHurtAlly.append("mob/villager/hit2");
  sounds_jsonHurtAlly.append("mob/villager/hit3");
  sounds_jsonHurtAlly.append("mob/villager/hit4");
  JSONArray sounds_jsonShootAlly = new JSONArray();
  sounds_jsonShootAlly.append("mob/ghast/fireball4");

  for (String mob : mobList) {
    String mobName = mob.substring(0, mob.length() - 6);
    String mobType = "";
    if (footsoldierList.hasValue(mob)) {
      mobType = "foot_soldiers";
    } else if (bossList.hasValue(mob)) {
      mobType = "bosses";
    } else if (allyList.hasValue(mob)) {
      mobType = "allies";
    }

    KamenRiderCraftSoundEvents += "\tpublic static final Supplier<SoundEvent> " + constants.get(mob) + "_AMBIENT = registerSoundEvent(\"entity.kamenridercraft." + identifiers.get(mob) + ".ambient\");\n";
    KamenRiderCraftSoundEvents += "\tpublic static final Supplier<SoundEvent> " + constants.get(mob) + "_HURT = registerSoundEvent(\"entity.kamenridercraft." + identifiers.get(mob) + ".hurt\");\n";
    KamenRiderCraftSoundEvents += "\tpublic static final Supplier<SoundEvent> " + constants.get(mob) + "_DEATH = registerSoundEvent(\"entity.kamenridercraft." + identifiers.get(mob) + ".death\");\n";
    KamenRiderCraftSoundEvents += "\tpublic static final Supplier<SoundEvent> " + constants.get(mob) + "_SHOOT = registerSoundEvent(\"entity.kamenridercraft." + identifiers.get(mob) + ".shoot\");\n";

    mixins_jsonMixins.append(mobType + "." + mob + "Mixin");

    JSONObject newAmbient = new JSONObject();
    newAmbient.setJSONArray("sounds", mobType == "allies"? sounds_jsonAmbientAlly : sounds_jsonAmbientEnemy);
    newAmbient.setString("subtitle", "subtitles.entity.kamenridercraft." + identifiers.get(mob) + ".ambient");
    sounds_json.setJSONObject("entity.kamenridercraft." + identifiers.get(mob) + ".ambient", newAmbient);
    JSONObject newDeath = new JSONObject();
    newDeath.setJSONArray("sounds", mobType == "allies"? sounds_jsonDeathAlly : sounds_jsonDeathEnemy);
    newDeath.setString("subtitle", "subtitles.entity.kamenridercraft." + identifiers.get(mob) + ".death");
    sounds_json.setJSONObject("entity.kamenridercraft." + identifiers.get(mob) + ".death", newDeath);
    JSONObject newHurt = new JSONObject();
    newHurt.setJSONArray("sounds", mobType == "allies"? sounds_jsonHurtAlly : sounds_jsonHurtEnemy);
    newHurt.setString("subtitle", "subtitles.entity.kamenridercraft." + identifiers.get(mob) + ".hurt");
    sounds_json.setJSONObject("entity.kamenridercraft." + identifiers.get(mob) + ".hurt", newHurt);
    JSONObject newShoot = new JSONObject();
    newShoot.setJSONArray("sounds", mobType == "allies"? sounds_jsonShootAlly : sounds_jsonShootEnemy);
    newShoot.setString("subtitle", "subtitles.entity.kamenridercraft." + identifiers.get(mob) + ".shoot");
    sounds_json.setJSONObject("entity.kamenridercraft." + identifiers.get(mob) + ".shoot", newShoot);

    lang_en_us.setString("subtitles.entity.kamenridercraft." + identifiers.get(mob) + ".ambient", origin_lang_en_us.getString("entity.kamenridercraft." + identifiers.get(mob)) + " murmurs");
    lang_en_us.setString("subtitles.entity.kamenridercraft." + identifiers.get(mob) + ".death", origin_lang_en_us.getString("entity.kamenridercraft." + identifiers.get(mob)) + " dies");
    lang_en_us.setString("subtitles.entity.kamenridercraft." + identifiers.get(mob) + ".hurt", origin_lang_en_us.getString("entity.kamenridercraft." + identifiers.get(mob)) + " hurts");
    lang_en_us.setString("subtitles.entity.kamenridercraft." + identifiers.get(mob) + ".shoot", origin_lang_en_us.getString("entity.kamenridercraft." + identifiers.get(mob)) + " shoots");

    lang_ja_jp.setString("subtitles.entity.kamenridercraft." + identifiers.get(mob) + ".ambient", origin_lang_ja_jp.getString("entity.kamenridercraft." + identifiers.get(mob)) + "がつぶやく");
    lang_ja_jp.setString("subtitles.entity.kamenridercraft." + identifiers.get(mob) + ".death", origin_lang_ja_jp.getString("entity.kamenridercraft." + identifiers.get(mob)) + "が死ぬ");
    lang_ja_jp.setString("subtitles.entity.kamenridercraft." + identifiers.get(mob) + ".hurt", origin_lang_ja_jp.getString("entity.kamenridercraft." + identifiers.get(mob)) + "がダメージを受ける");
    lang_ja_jp.setString("subtitles.entity.kamenridercraft." + identifiers.get(mob) + ".shoot", origin_lang_ja_jp.getString("entity.kamenridercraft." + identifiers.get(mob)) + "が発射する");

    lang_zh_cn.setString("subtitles.entity.kamenridercraft." + identifiers.get(mob) + ".ambient", origin_lang_zh_cn.getString("entity.kamenridercraft." + identifiers.get(mob)) + "：咕哝");
    lang_zh_cn.setString("subtitles.entity.kamenridercraft." + identifiers.get(mob) + ".death", origin_lang_zh_cn.getString("entity.kamenridercraft." + identifiers.get(mob)) + "：死亡");
    lang_zh_cn.setString("subtitles.entity.kamenridercraft." + identifiers.get(mob) + ".hurt", origin_lang_zh_cn.getString("entity.kamenridercraft." + identifiers.get(mob)) + "：受伤");
    lang_zh_cn.setString("subtitles.entity.kamenridercraft." + identifiers.get(mob) + ".shoot", origin_lang_zh_cn.getString("entity.kamenridercraft." + identifiers.get(mob)) + "：射击");

    if (mobType == "foot_soldiers" && !mob.equals(referenceFootsoldier)) {
      saveStrings("../../src/main/java/net/a11v1r15/kamenridercraftsoundevents/mixin/foot_soldiers/" + mob + "Mixin.java",
        footsoldierMixin.replace(referenceFootsoldierName, mobName).replace(constants.get(referenceFootsoldier), constants.get(mob)).split("\n"));
    } else if (mobType == "bosses") {
      saveStrings("../../src/main/java/net/a11v1r15/kamenridercraftsoundevents/mixin/bosses/" + mob + "Mixin.java",
        bossMixin.replace(referenceFootsoldierName, mobName).replace(constants.get(referenceFootsoldier), constants.get(mob)).split("\n"));
    } else if (mobType == "allies" && !mob.equals(referenceAlly)) {
      saveStrings("../../src/main/java/net/a11v1r15/kamenridercraftsoundevents/mixin/allies/" + mob + "Mixin.java",
        allyMixin.replace(referenceAllyName, mobName).replace(constants.get(referenceAlly), constants.get(mob)).split("\n"));
    }
  }
  String mainJava = String.join("\n", loadStrings("../../../src/main/java/net/a11v1r15/kamenridercraftsoundevents/KamenRiderCraftSoundEvents.java"));
  String mainJavaGenerated = match(mainJava, "//GENERATED(.*?)//GENERATED_END")[1];
  mainJava = mainJava.replace(mainJavaGenerated, "\n" + KamenRiderCraftSoundEvents);
  saveStrings("../../src/main/java/net/a11v1r15/kamenridercraftsoundevents/KamenRiderCraftSoundEvents.java", mainJava.split("\n\'"));

  mixins_json.setJSONArray("mixins", mixins_jsonMixins);
  saveJSONObject(mixins_json, "../../src/main/resources/kamenridercraftsoundevents.mixins.json");

  saveJSONObject(sounds_json, "../../src/main/resources/assets/kamenridercraftsoundevents/sounds.json");

  saveJSONObject(lang_en_us, "../../src/main/resources/assets/kamenridercraftsoundevents/lang/en_us.json");
  saveJSONObject(lang_ja_jp, "../../src/main/resources/assets/kamenridercraftsoundevents/lang/ja_jp.json");
  saveJSONObject(lang_zh_cn, "../../src/main/resources/assets/kamenridercraftsoundevents/lang/zh_cn.json");

  exit();
}
