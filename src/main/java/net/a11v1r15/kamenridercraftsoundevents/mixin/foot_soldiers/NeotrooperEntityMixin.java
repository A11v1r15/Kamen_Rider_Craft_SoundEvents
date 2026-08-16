package net.a11v1r15.kamenridercraftsoundevents.mixin.foot_soldiers;

import org.spongepowered.asm.mixin.Mixin;

import com.kelco.kamenridercraft.entity.mobs.foot_soldiers.NeotrooperEntity;
import com.kelco.kamenridercraft.entity.mobs.foot_soldiers.BaseHenchmenEntity;

import net.a11v1r15.kamenridercraftsoundevents.KamenRiderCraftSoundEvents;
import net.a11v1r15.kamenridercraftsoundevents.ShootSoundProvider;
import net.minecraft.sounds.SoundEvent;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.level.Level;

@Mixin(value = NeotrooperEntity.class)
public abstract class NeotrooperEntityMixin extends BaseHenchmenEntity implements ShootSoundProvider {
    public NeotrooperEntityMixin(EntityType<? extends BaseHenchmenEntity> type, Level level) {
		super(type, level);
	}
	
	@Override
    public SoundEvent getAmbientSound() {
        return KamenRiderCraftSoundEvents.NEOTROOPER_AMBIENT.get();
    }
	
	@Override
    public SoundEvent getHurtSound(DamageSource source) {
        return KamenRiderCraftSoundEvents.NEOTROOPER_HURT.get();
    }
	
	@Override
    public SoundEvent getDeathSound() {
        return KamenRiderCraftSoundEvents.NEOTROOPER_DEATH.get();
    }
	
	@Override
    public SoundEvent getShootSound() {
        return KamenRiderCraftSoundEvents.NEOTROOPER_SHOOT.get();
    }
}
