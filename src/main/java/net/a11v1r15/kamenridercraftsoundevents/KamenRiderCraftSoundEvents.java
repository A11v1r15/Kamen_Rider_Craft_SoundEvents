package net.a11v1r15.kamenridercraftsoundevents;

import java.util.function.Supplier;

import org.slf4j.Logger;

import com.mojang.logging.LogUtils;

import net.minecraft.core.registries.BuiltInRegistries;
import net.minecraft.resources.ResourceLocation;
import net.minecraft.sounds.SoundEvent;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.fml.common.Mod;
import net.neoforged.fml.ModContainer;
import net.neoforged.neoforge.registries.DeferredRegister;

// The value here should match an entry in the META-INF/neoforge.mods.toml file
@Mod(KamenRiderCraftSoundEvents.MODID)
public class KamenRiderCraftSoundEvents {
	// Define mod id in a common place for everything to reference
	public static final String MODID = "kamenridercraftsoundevents";
	// Directly reference a slf4j logger
	public static final Logger LOGGER = LogUtils.getLogger();

	public static final DeferredRegister<SoundEvent> SOUND_EVENTS = DeferredRegister.create(BuiltInRegistries.SOUND_EVENT, KamenRiderCraftSoundEvents.MODID);

	public static final Supplier<SoundEvent> HENCHMAN_AMBIENT = registerSoundEvent("entity.kamenridercraft.henchman.ambient");
	public static final Supplier<SoundEvent> HENCHMAN_HURT = registerSoundEvent("entity.kamenridercraft.henchman.hurt");
	public static final Supplier<SoundEvent> HENCHMAN_DEATH = registerSoundEvent("entity.kamenridercraft.henchman.death");
	public static final Supplier<SoundEvent> HENCHMAN_STEP = registerSoundEvent("entity.kamenridercraft.henchman.step");
	public static final Supplier<SoundEvent> HENCHMAN_SHOOT = registerSoundEvent("entity.kamenridercraft.henchman.shoot");

	private static Supplier<SoundEvent> registerSoundEvent(String name) {
		ResourceLocation id = ResourceLocation.fromNamespaceAndPath(KamenRiderCraftSoundEvents.MODID, name);
		return SOUND_EVENTS.register(name, () -> SoundEvent.createVariableRangeEvent(id));
	}

	public static void register(IEventBus eventBus) {
		SOUND_EVENTS.register(eventBus);
	}

	public KamenRiderCraftSoundEvents(IEventBus modEventBus, ModContainer modContainer) {
		register(modEventBus);
	}
}
