package net.a11v1r15.kamenridercraftsoundevents.mixin.allies;

import org.spongepowered.asm.mixin.Mixin;

import com.kelco.kamenridercraft.entity.mobs.allies.UratarosEntity;
import com.kelco.kamenridercraft.entity.mobs.allies.BaseAllyEntity;

import net.a11v1r15.kamenridercraftsoundevents.KamenRiderCraftSoundEvents;
import net.a11v1r15.kamenridercraftsoundevents.ShootSoundProvider;
import net.minecraft.sounds.SoundEvent;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.level.Level;

@Mixin(value = UratarosEntity.class)
public abstract class UratarosEntityMixin extends BaseAllyEntity implements ShootSoundProvider {
    public UratarosEntityMixin(EntityType<? extends BaseAllyEntity> type, Level level) {
		super(type, level);
	}
	
	@Override
    public SoundEvent getAmbientSound() {
        return KamenRiderCraftSoundEvents.URATAROS_AMBIENT.get();
    }
	
	@Override
    public SoundEvent getHurtSound(DamageSource source) {
        return KamenRiderCraftSoundEvents.URATAROS_HURT.get();
    }
	
	@Override
    public SoundEvent getDeathSound() {
        return KamenRiderCraftSoundEvents.URATAROS_DEATH.get();
    }
	
	@Override
    public SoundEvent getShootSound() {
        return KamenRiderCraftSoundEvents.URATAROS_SHOOT.get();
    }
}
