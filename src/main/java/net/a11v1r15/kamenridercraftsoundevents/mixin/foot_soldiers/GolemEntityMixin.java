package net.a11v1r15.kamenridercraftsoundevents.mixin.foot_soldiers;

import org.spongepowered.asm.mixin.Mixin;

import com.kelco.kamenridercraft.entity.mobs.foot_soldiers.GolemEntity;
import com.kelco.kamenridercraft.entity.mobs.foot_soldiers.BaseHenchmenEntity;

import net.a11v1r15.kamenridercraftsoundevents.KamenRiderCraftSoundEvents;
import net.a11v1r15.kamenridercraftsoundevents.ShootSoundProvider;
import net.minecraft.sounds.SoundEvent;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.level.Level;

@Mixin(value = GolemEntity.class)
public abstract class GolemEntityMixin extends BaseHenchmenEntity implements ShootSoundProvider {
    public GolemEntityMixin(EntityType<? extends BaseHenchmenEntity> type, Level level) {
		super(type, level);
	}
	
	@Override
    public SoundEvent getAmbientSound() {
        return KamenRiderCraftSoundEvents.GOLEM_AMBIENT.get();
    }
	
	@Override
    public SoundEvent getHurtSound(DamageSource source) {
        return KamenRiderCraftSoundEvents.GOLEM_HURT.get();
    }
	
	@Override
    public SoundEvent getDeathSound() {
        return KamenRiderCraftSoundEvents.GOLEM_DEATH.get();
    }
	
	@Override
    public SoundEvent getShootSound() {
        return KamenRiderCraftSoundEvents.GOLEM_SHOOT.get();
    }
}
