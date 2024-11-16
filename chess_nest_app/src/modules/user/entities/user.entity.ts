import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

@Schema()
export class User extends Document {
  @Prop()
  name: string;

  @Prop({
    unique: true,
  })
  email: string;

  @Prop({
    minlength: 8,
  })
  password: string;

  @Prop({
    default: 0,
  })
  score: number;
}

export const UserSchema = SchemaFactory.createForClass(User);
