package net.a11v1r15.kamenridercraftsoundevents.mixin.bosses;

import org.spongepowered.asm.mixin.Mixin;

import com.kelco.kamenridercraft.entity.mobs.bosses.CatastropheGoreNightmareEntity;
import com.kelco.kamenridercraft.entity.mobs.foot_soldiers.BaseHenchmenEntity;

import net.a11v1r15.kamenridercraftsoundevents.KamenRiderCraftSoundEvents;
import net.a11v1r15.kamenridercraftsoundevents.ShootSoundProvider;
import net.minecraft.sounds.SoundEvent;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.level.Level;

@Mixin(value = CatastropheGoreNightmareEntity.class)
public abstract class CatastropheGoreNightmareEntityMixin extends BaseHenchmenEntity implements ShootSoundProvider {
    public CatastropheGoreNightmareEntityMixin(EntityType<? extends BaseHenchmenEntity> type, Level level) {
		super(type, level);
	}
	
	@Override
    public SoundEvent getAmbientSound() {
        return KamenRiderCraftSoundEvents.CATASTROPHE_GORE_NIGHTMARE_AMBIENT.get();
    }
	
	@Override
    public SoundEvent getHurtSound(DamageSource source) {
        return KamenRiderCraftSoundEvents.CATASTROPHE_GORE_NIGHTMARE_HURT.get();
    }
	
	@Override
    public SoundEvent getDeathSound() {
        return KamenRiderCraftSoundEvents.CATASTROPHE_GORE_NIGHTMARE_DEATH.get();
    }
	
	@Override
    public SoundEvent getShootSound() {
        return KamenRiderCraftSoundEvents.CATASTROPHE_GORE_NIGHTMARE_SHOOT.get();
    }
}
