package net.a11v1r15.kamenridercraftsoundevents.mixin.foot_soldiers;

import org.spongepowered.asm.mixin.Mixin;

import com.kelco.kamenridercraft.entity.mobs.foot_soldiers.BlackSatanSoldierEntity;
import com.kelco.kamenridercraft.entity.mobs.foot_soldiers.BaseHenchmenEntity;

import net.a11v1r15.kamenridercraftsoundevents.KamenRiderCraftSoundEvents;
import net.a11v1r15.kamenridercraftsoundevents.ShootSoundProvider;
import net.minecraft.sounds.SoundEvent;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.level.Level;

@Mixin(value = BlackSatanSoldierEntity.class)
public abstract class BlackSatanSoldierEntityMixin extends BaseHenchmenEntity implements ShootSoundProvider {
    public BlackSatanSoldierEntityMixin(EntityType<? extends BaseHenchmenEntity> type, Level level) {
		super(type, level);
	}
	
	@Override
    public SoundEvent getAmbientSound() {
        return KamenRiderCraftSoundEvents.BLACK_SATAN_SOLDIER_AMBIENT.get();
    }
	
	@Override
    public SoundEvent getHurtSound(DamageSource source) {
        return KamenRiderCraftSoundEvents.BLACK_SATAN_SOLDIER_HURT.get();
    }
	
	@Override
    public SoundEvent getDeathSound() {
        return KamenRiderCraftSoundEvents.BLACK_SATAN_SOLDIER_DEATH.get();
    }
	
	@Override
    public SoundEvent getShootSound() {
        return KamenRiderCraftSoundEvents.BLACK_SATAN_SOLDIER_SHOOT.get();
    }
}
