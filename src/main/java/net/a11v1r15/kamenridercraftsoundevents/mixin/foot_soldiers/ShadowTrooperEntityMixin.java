package net.a11v1r15.kamenridercraftsoundevents.mixin.foot_soldiers;

import org.spongepowered.asm.mixin.Mixin;

import com.kelco.kamenridercraft.entity.mobs.foot_soldiers.ShadowTrooperEntity;
import com.kelco.kamenridercraft.entity.mobs.foot_soldiers.BaseHenchmenEntity;

import net.a11v1r15.kamenridercraftsoundevents.KamenRiderCraftSoundEvents;
import net.a11v1r15.kamenridercraftsoundevents.ShootSoundProvider;
import net.minecraft.sounds.SoundEvent;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.level.Level;

@Mixin(value = ShadowTrooperEntity.class)
public abstract class ShadowTrooperEntityMixin extends BaseHenchmenEntity implements ShootSoundProvider {
    public ShadowTrooperEntityMixin(EntityType<? extends BaseHenchmenEntity> type, Level level) {
		super(type, level);
	}
	
	@Override
    public SoundEvent getAmbientSound() {
        return KamenRiderCraftSoundEvents.SHADOW_TROOPER_AMBIENT.get();
    }
	
	@Override
    public SoundEvent getHurtSound(DamageSource source) {
        return KamenRiderCraftSoundEvents.SHADOW_TROOPER_HURT.get();
    }
	
	@Override
    public SoundEvent getDeathSound() {
        return KamenRiderCraftSoundEvents.SHADOW_TROOPER_DEATH.get();
    }
	
	@Override
    public SoundEvent getShootSound() {
        return KamenRiderCraftSoundEvents.SHADOW_TROOPER_SHOOT.get();
    }
}
