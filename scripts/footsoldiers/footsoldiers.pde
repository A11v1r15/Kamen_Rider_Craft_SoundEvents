String[] footsoldierList;
StringDict constants = new StringDict();
StringDict identifiers = new StringDict();
String mixin;

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
  footsoldierList = loadStrings("footsoldiers.txt");
  mixin = String.join("\n'", loadStrings("../../../src/main/java/net/a11v1r15/kamenridercraftsoundevents/mixin/foot_soldiers/AbaddonEntityMixin.java"));

  String firstFootsoldier = footsoldierList[0];
  String firstFootsoldierName = firstFootsoldier.substring(0, firstFootsoldier.length() - 6);

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

  for (String footsoldier : footsoldierList) {
    String footsoldierName = footsoldier.substring(0, footsoldier.length() - 6);
    if (!footsoldier.equals(firstFootsoldier)) {
      KamenRiderCraftSoundEvents += "  public static final Supplier<SoundEvent> " + constants.get(footsoldier) + "_AMBIENT = registerSoundEvent(\"entity.kamenridercraft." + identifiers.get(footsoldier) + ".ambient\");\n";
      KamenRiderCraftSoundEvents += "  public static final Supplier<SoundEvent> " + constants.get(footsoldier) + "_HURT = registerSoundEvent(\"entity.kamenridercraft." + identifiers.get(footsoldier) + ".hurt\");\n";
      KamenRiderCraftSoundEvents += "  public static final Supplier<SoundEvent> " + constants.get(footsoldier) + "_DEATH = registerSoundEvent(\"entity.kamenridercraft." + identifiers.get(footsoldier) + ".death\");\n";
      KamenRiderCraftSoundEvents += "  public static final Supplier<SoundEvent> " + constants.get(footsoldier) + "_SHOOT = registerSoundEvent(\"entity.kamenridercraft." + identifiers.get(footsoldier) + ".shoot\");\n";

      mixins_jsonMixins.append("foot_soldiers." + footsoldier + "Mixin");

      JSONObject newAmbient = new JSONObject();
      newAmbient.setJSONArray("sounds", sounds_jsonAmbient);
      newAmbient.setString("subtitle", "subtitles.entity.kamenridercraft." + identifiers.get(footsoldier) + ".ambient");
      sounds_json.setJSONObject("entity.kamenridercraft." + identifiers.get(footsoldier) + ".ambient", newAmbient);
      JSONObject newDeath = new JSONObject();
      newDeath.setJSONArray("sounds", sounds_jsonDeath);
      newDeath.setString("subtitle", "subtitles.entity.kamenridercraft." + identifiers.get(footsoldier) + ".death");
      sounds_json.setJSONObject("entity.kamenridercraft." + identifiers.get(footsoldier) + ".death", newDeath);
      JSONObject newHurt = new JSONObject();
      newHurt.setJSONArray("sounds", sounds_jsonHurt);
      newHurt.setString("subtitle", "subtitles.entity.kamenridercraft." + identifiers.get(footsoldier) + ".hurt");
      sounds_json.setJSONObject("entity.kamenridercraft." + identifiers.get(footsoldier) + ".hurt", newHurt);
      JSONObject newShoot = new JSONObject();
      newShoot.setJSONArray("sounds", sounds_jsonShoot);
      newShoot.setString("subtitle", "subtitles.entity.kamenridercraft." + identifiers.get(footsoldier) + ".shoot");
      sounds_json.setJSONObject("entity.kamenridercraft." + identifiers.get(footsoldier) + ".shoot", newShoot);
      
      lang_en_us.setString("subtitles.entity.kamenridercraft." + identifiers.get(footsoldier) + ".ambient", origin_lang_en_us.getString("entity.kamenridercraft." + identifiers.get(footsoldier)) + " murmurs");
      lang_en_us.setString("subtitles.entity.kamenridercraft." + identifiers.get(footsoldier) + ".death", origin_lang_en_us.getString("entity.kamenridercraft." + identifiers.get(footsoldier)) + " dies");
      lang_en_us.setString("subtitles.entity.kamenridercraft." + identifiers.get(footsoldier) + ".hurt", origin_lang_en_us.getString("entity.kamenridercraft." + identifiers.get(footsoldier)) + " hurts");
      lang_en_us.setString("subtitles.entity.kamenridercraft." + identifiers.get(footsoldier) + ".shoot", origin_lang_en_us.getString("entity.kamenridercraft." + identifiers.get(footsoldier)) + " shoots");
      
      lang_ja_jp.setString("subtitles.entity.kamenridercraft." + identifiers.get(footsoldier) + ".ambient", origin_lang_ja_jp.getString("entity.kamenridercraft." + identifiers.get(footsoldier)) + "がつぶやく");
      lang_ja_jp.setString("subtitles.entity.kamenridercraft." + identifiers.get(footsoldier) + ".death", origin_lang_ja_jp.getString("entity.kamenridercraft." + identifiers.get(footsoldier)) + "が死ぬ");
      lang_ja_jp.setString("subtitles.entity.kamenridercraft." + identifiers.get(footsoldier) + ".hurt", origin_lang_ja_jp.getString("entity.kamenridercraft." + identifiers.get(footsoldier)) + "がダメージを受ける");
      lang_ja_jp.setString("subtitles.entity.kamenridercraft." + identifiers.get(footsoldier) + ".shoot", origin_lang_ja_jp.getString("entity.kamenridercraft." + identifiers.get(footsoldier)) + "が発射する");
      
      lang_zh_cn.setString("subtitles.entity.kamenridercraft." + identifiers.get(footsoldier) + ".ambient", origin_lang_zh_cn.getString("entity.kamenridercraft." + identifiers.get(footsoldier)) + "：咕哝");
      lang_zh_cn.setString("subtitles.entity.kamenridercraft." + identifiers.get(footsoldier) + ".death", origin_lang_zh_cn.getString("entity.kamenridercraft." + identifiers.get(footsoldier)) + "：死亡");
      lang_zh_cn.setString("subtitles.entity.kamenridercraft." + identifiers.get(footsoldier) + ".hurt", origin_lang_zh_cn.getString("entity.kamenridercraft." + identifiers.get(footsoldier)) + "：受伤");
      lang_zh_cn.setString("subtitles.entity.kamenridercraft." + identifiers.get(footsoldier) + ".shoot", origin_lang_zh_cn.getString("entity.kamenridercraft." + identifiers.get(footsoldier)) + "：射击");

      saveStrings("../../src/main/java/net/a11v1r15/kamenridercraftsoundevents/mixin/foot_soldiers/" + footsoldier + "Mixin.java",
        mixin.replace(firstFootsoldierName, footsoldierName).replace(constants.get(firstFootsoldier), constants.get(footsoldier)).split("\n\'"));
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
