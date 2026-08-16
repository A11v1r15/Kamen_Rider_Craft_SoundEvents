StringList footsoldierList = new StringList();
StringList bossList = new StringList();
StringList enemyList = new StringList();
StringDict constants = new StringDict();
StringDict identifiers = new StringDict();
String footsoldierMixin;
String bossMixin;

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
  enemyList.append(footsoldierList);
  enemyList.append(bossList);
  enemyList.sort();
  footsoldierMixin = String.join("\n'", loadStrings("../../../src/main/java/net/a11v1r15/kamenridercraftsoundevents/mixin/foot_soldiers/AbaddonEntityMixin.java"));
  bossMixin = footsoldierMixin
    .replace("package net.a11v1r15.kamenridercraftsoundevents.mixin.foot_soldiers;", "package net.a11v1r15.kamenridercraftsoundevents.mixin.bosses;")
    .replace("import com.kelco.kamenridercraft.entity.mobs.foot_soldiers.AbaddonEntity;", "import com.kelco.kamenridercraft.entity.mobs.bosses.AbaddonEntity;");

  String referenceFootsoldier = "AbaddonEntity";
  String referenceFootsoldierName = referenceFootsoldier.substring(0, referenceFootsoldier.length() - 6);

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

  JSONArray sounds_jsonAmbient = new JSONArray();
  sounds_jsonAmbient.append("mob/pillager/idle1");
  sounds_jsonAmbient.append("mob/pillager/idle2");
  sounds_jsonAmbient.append("mob/pillager/idle3");
  sounds_jsonAmbient.append("mob/pillager/idle4");
  JSONArray sounds_jsonDeath = new JSONArray();
  sounds_jsonDeath.append("mob/pillager/death1");
  sounds_jsonDeath.append("mob/pillager/death2");
  JSONArray sounds_jsonHurt = new JSONArray();
  sounds_jsonHurt.append("mob/pillager/hurt1");
  sounds_jsonHurt.append("mob/pillager/hurt2");
  sounds_jsonHurt.append("mob/pillager/hurt3");
  JSONArray sounds_jsonShoot = new JSONArray();
  sounds_jsonShoot.append("mob/ghast/fireball4");

  for (String enemy : enemyList) {
    String enemyName = enemy.substring(0, enemy.length() - 6);
    String enemyType = "";
    if (footsoldierList.hasValue(enemy)) {
      enemyType = "foot_soldiers";
    } else if (bossList.hasValue(enemy)) {
      enemyType = "bosses";
    }
    if (!enemy.equals(referenceFootsoldier)) {
      KamenRiderCraftSoundEvents += "  public static final Supplier<SoundEvent> " + constants.get(enemy) + "_AMBIENT = registerSoundEvent(\"entity.kamenridercraft." + identifiers.get(enemy) + ".ambient\");\n";
      KamenRiderCraftSoundEvents += "  public static final Supplier<SoundEvent> " + constants.get(enemy) + "_HURT = registerSoundEvent(\"entity.kamenridercraft." + identifiers.get(enemy) + ".hurt\");\n";
      KamenRiderCraftSoundEvents += "  public static final Supplier<SoundEvent> " + constants.get(enemy) + "_DEATH = registerSoundEvent(\"entity.kamenridercraft." + identifiers.get(enemy) + ".death\");\n";
      KamenRiderCraftSoundEvents += "  public static final Supplier<SoundEvent> " + constants.get(enemy) + "_SHOOT = registerSoundEvent(\"entity.kamenridercraft." + identifiers.get(enemy) + ".shoot\");\n";

      mixins_jsonMixins.append(enemyType + "." + enemy + "Mixin");

      JSONObject newAmbient = new JSONObject();
      newAmbient.setJSONArray("sounds", sounds_jsonAmbient);
      newAmbient.setString("subtitle", "subtitles.entity.kamenridercraft." + identifiers.get(enemy) + ".ambient");
      sounds_json.setJSONObject("entity.kamenridercraft." + identifiers.get(enemy) + ".ambient", newAmbient);
      JSONObject newDeath = new JSONObject();
      newDeath.setJSONArray("sounds", sounds_jsonDeath);
      newDeath.setString("subtitle", "subtitles.entity.kamenridercraft." + identifiers.get(enemy) + ".death");
      sounds_json.setJSONObject("entity.kamenridercraft." + identifiers.get(enemy) + ".death", newDeath);
      JSONObject newHurt = new JSONObject();
      newHurt.setJSONArray("sounds", sounds_jsonHurt);
      newHurt.setString("subtitle", "subtitles.entity.kamenridercraft." + identifiers.get(enemy) + ".hurt");
      sounds_json.setJSONObject("entity.kamenridercraft." + identifiers.get(enemy) + ".hurt", newHurt);
      JSONObject newShoot = new JSONObject();
      newShoot.setJSONArray("sounds", sounds_jsonShoot);
      newShoot.setString("subtitle", "subtitles.entity.kamenridercraft." + identifiers.get(enemy) + ".shoot");
      sounds_json.setJSONObject("entity.kamenridercraft." + identifiers.get(enemy) + ".shoot", newShoot);

      lang_en_us.setString("subtitles.entity.kamenridercraft." + identifiers.get(enemy) + ".ambient", origin_lang_en_us.getString("entity.kamenridercraft." + identifiers.get(enemy)) + " murmurs");
      lang_en_us.setString("subtitles.entity.kamenridercraft." + identifiers.get(enemy) + ".death", origin_lang_en_us.getString("entity.kamenridercraft." + identifiers.get(enemy)) + " dies");
      lang_en_us.setString("subtitles.entity.kamenridercraft." + identifiers.get(enemy) + ".hurt", origin_lang_en_us.getString("entity.kamenridercraft." + identifiers.get(enemy)) + " hurts");
      lang_en_us.setString("subtitles.entity.kamenridercraft." + identifiers.get(enemy) + ".shoot", origin_lang_en_us.getString("entity.kamenridercraft." + identifiers.get(enemy)) + " shoots");

      lang_ja_jp.setString("subtitles.entity.kamenridercraft." + identifiers.get(enemy) + ".ambient", origin_lang_ja_jp.getString("entity.kamenridercraft." + identifiers.get(enemy)) + "がつぶやく");
      lang_ja_jp.setString("subtitles.entity.kamenridercraft." + identifiers.get(enemy) + ".death", origin_lang_ja_jp.getString("entity.kamenridercraft." + identifiers.get(enemy)) + "が死ぬ");
      lang_ja_jp.setString("subtitles.entity.kamenridercraft." + identifiers.get(enemy) + ".hurt", origin_lang_ja_jp.getString("entity.kamenridercraft." + identifiers.get(enemy)) + "がダメージを受ける");
      lang_ja_jp.setString("subtitles.entity.kamenridercraft." + identifiers.get(enemy) + ".shoot", origin_lang_ja_jp.getString("entity.kamenridercraft." + identifiers.get(enemy)) + "が発射する");

      lang_zh_cn.setString("subtitles.entity.kamenridercraft." + identifiers.get(enemy) + ".ambient", origin_lang_zh_cn.getString("entity.kamenridercraft." + identifiers.get(enemy)) + "：咕哝");
      lang_zh_cn.setString("subtitles.entity.kamenridercraft." + identifiers.get(enemy) + ".death", origin_lang_zh_cn.getString("entity.kamenridercraft." + identifiers.get(enemy)) + "：死亡");
      lang_zh_cn.setString("subtitles.entity.kamenridercraft." + identifiers.get(enemy) + ".hurt", origin_lang_zh_cn.getString("entity.kamenridercraft." + identifiers.get(enemy)) + "：受伤");
      lang_zh_cn.setString("subtitles.entity.kamenridercraft." + identifiers.get(enemy) + ".shoot", origin_lang_zh_cn.getString("entity.kamenridercraft." + identifiers.get(enemy)) + "：射击");

      if (enemyType == "foot_soldiers") {
        saveStrings("../../src/main/java/net/a11v1r15/kamenridercraftsoundevents/mixin/foot_soldiers/" + enemy + "Mixin.java",
          footsoldierMixin.replace(referenceFootsoldierName, enemyName).replace(constants.get(referenceFootsoldier), constants.get(enemy)).split("\n\'"));
      } else if (enemyType == "bosses") {
        saveStrings("../../src/main/java/net/a11v1r15/kamenridercraftsoundevents/mixin/bosses/" + enemy + "Mixin.java",
          bossMixin.replace(referenceFootsoldierName, enemyName).replace(constants.get(referenceFootsoldier), constants.get(enemy)).split("\n\'"));
      }
    }
  }
  saveStrings("KamenRiderCraftSoundEvents.txt", KamenRiderCraftSoundEvents.split("\n"));

  mixins_json.setJSONArray("mixins", mixins_jsonMixins);
  saveJSONObject(mixins_json, "../../src/main/resources/kamenridercraftsoundevents.mixins.json");

  saveJSONObject(sounds_json, "../../src/main/resources/assets/kamenridercraftsoundevents/sounds.json");

  saveJSONObject(lang_en_us, "../../src/main/resources/assets/kamenridercraftsoundevents/lang/en_us.json");
  saveJSONObject(lang_ja_jp, "../../src/main/resources/assets/kamenridercraftsoundevents/lang/ja_jp.json");
  saveJSONObject(lang_zh_cn, "../../src/main/resources/assets/kamenridercraftsoundevents/lang/zh_cn.json");

  exit();
}
