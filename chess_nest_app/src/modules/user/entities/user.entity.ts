import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

// This is where you define the schema and properties
@Schema()
export class User extends Document {
  @Prop()
  name: string;

  @Prop({ unique: true })
  email: string;

  @Prop({ minlength: 8 })
  password: string;

  @Prop({ default: 0 })
  score: number;

  // New fields for password reset functionality
  @Prop()
  resetPasswordToken: string;

  @Prop()
  resetPasswordExpires: Date;
}

// This creates the Mongoose schema from the User class
export const UserSchema = SchemaFactory.createForClass(User);
