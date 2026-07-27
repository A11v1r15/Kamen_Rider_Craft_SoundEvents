package net.a11v1r15.kamenridercraftsoundevents.mixin.foot_soldiers;

import org.spongepowered.asm.mixin.Mixin;

import com.kelco.kamenridercraft.entity.mobs.foot_soldiers.AbaddonEntity;
import com.kelco.kamenridercraft.entity.mobs.foot_soldiers.BaseHenchmenEntity;

import net.a11v1r15.kamenridercraftsoundevents.KamenRiderCraftSoundEvents;
import net.a11v1r15.kamenridercraftsoundevents.ShootSoundProvider;
import net.minecraft.sounds.SoundEvent;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.level.Level;

@Mixin(value = AbaddonEntity.class)
public abstract class AbaddonEntityMixin extends BaseHenchmenEntity implements ShootSoundProvider {
    public AbaddonEntityMixin(EntityType<? extends BaseHenchmenEntity> type, Level level) {
		super(type, level);
	}
	
	@Override
    public SoundEvent getAmbientSound() {
        return KamenRiderCraftSoundEvents.ABADDON_AMBIENT.get();
    }
	
	@Override
    public SoundEvent getHurtSound(DamageSource source) {
        return KamenRiderCraftSoundEvents.ABADDON_HURT.get();
    }
	
	@Override
    public SoundEvent getDeathSound() {
        return KamenRiderCraftSoundEvents.ABADDON_DEATH.get();
    }
	
	@Override
    public SoundEvent getShootSound() {
        return KamenRiderCraftSoundEvents.ABADDON_SHOOT.get();
    }
}
