package net.a11v1r15.kamenridercraftsoundevents.mixin;

import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.ModifyArg;

import com.kelco.kamenridercraft.entity.mobs.foot_soldiers.BaseHenchmenEntity;
import com.llamalad7.mixinextras.injector.ModifyReturnValue;

import net.a11v1r15.kamenridercraftsoundevents.KamenRiderCraftSoundEvents;
import net.a11v1r15.kamenridercraftsoundevents.ShootSoundProvider;
import net.minecraft.sounds.SoundEvent;

@Mixin(value = BaseHenchmenEntity.class)
public abstract class BaseHenchmenEntityMixin implements ShootSoundProvider {
    @ModifyReturnValue(at = @At("RETURN"),
	method = "getAmbientSound()Lnet/minecraft/sounds/SoundEvent;")
	private SoundEvent kamenridercraftsoundevents$changeAmbientSound(SoundEvent original) {
		return KamenRiderCraftSoundEvents.HENCHMAN_AMBIENT.get();
	}
	
    @ModifyReturnValue(at = @At("RETURN"),
	method = "getHurtSound(Lnet/minecraft/world/damagesource/DamageSource;)Lnet/minecraft/sounds/SoundEvent;")
	private SoundEvent kamenridercraftsoundevents$changeHurtSound(SoundEvent original) {
		return KamenRiderCraftSoundEvents.HENCHMAN_HURT.get();
	}
	
    @ModifyReturnValue(at = @At("RETURN"),
	method = "getDeathSound()Lnet/minecraft/sounds/SoundEvent;")
	private SoundEvent kamenridercraftsoundevents$changeDeathSound(SoundEvent original) {
		return KamenRiderCraftSoundEvents.HENCHMAN_DEATH.get();
	}
	
    @ModifyReturnValue(at = @At("RETURN"),
	method = "getStepSound()Lnet/minecraft/sounds/SoundEvent;")
	private SoundEvent kamenridercraftsoundevents$changeStepSound(SoundEvent original) {
		return KamenRiderCraftSoundEvents.HENCHMAN_STEP.get();
	}
	
	@Override
    public SoundEvent getShootSound() {
        return KamenRiderCraftSoundEvents.HENCHMAN_SHOOT.get();
    }

	@ModifyArg( at = @At(
		value = "INVOKE",
		target = "playSound(Lnet/minecraft/sounds/SoundEvent;FF)V"
	), index = 0,
	method = "performRangedAttack(Lnet/minecraft/world/entity/LivingEntity;F)V")
	private SoundEvent kamenridercraftsoundevents$changeShootSound(SoundEvent original) {
		return ((ShootSoundProvider)this).getShootSound();
	}
}
