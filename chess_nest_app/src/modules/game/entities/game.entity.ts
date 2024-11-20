import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import mongoose, { Document } from 'mongoose';
import { User } from '../../user/entities/user.entity';

export enum GameStatus {
  PENDING = 'pending',
  PLAYING = 'playing',
  FINISHED = 'finished',
}

@Schema()
export class Game extends Document {
  @Prop({
    default: 0,
  })
  score: number;

  @Prop({
    type: mongoose.Schema.Types.ObjectId,
    ref: User.name,
  })
  player: User;

  @Prop({
    enum: Object.values(GameStatus),
    default: GameStatus.PENDING,
  })
  status: GameStatus;

  @Prop({
    default: Date.now,
  })
  startedAt: Date;

  @Prop({
    default: null,
  })
  finishedAt: Date;
}

export const GameSchema = SchemaFactory.createForClass(Game);
