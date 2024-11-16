import {
  ConflictException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { BaseService } from '../../core/base.service';
import { User } from './entities/user.entity';
import { Model } from 'mongoose';
import { InjectModel } from '@nestjs/mongoose';
import { comparePassword, cryptPassword } from '../../utils';
import { SignInDto } from './dto/sign-in.dto';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class UserService extends BaseService<
  User,
  CreateUserDto,
  UpdateUserDto
> {
  constructor(
    @InjectModel(User.name) private readonly userModel: Model<User>,
    private readonly jwtService: JwtService,
  ) {
    super(userModel);
  }

  findByEmail(email: string): Promise<User> {
    return this.findOne({ email });
  }

  findByEmailOrFail(email: string): Promise<User> {
    return this.findOneOrFail({ email });
  }

  async signUp(signUpDto: CreateUserDto) {
    const existedUser = await this.findByEmail(signUpDto.email);
    if (existedUser)
      throw new ConflictException('User with this email already exists');

    return await this.create({
      ...signUpDto,
      password: await cryptPassword(signUpDto.password),
    });
  }

  async signIn(credentials: SignInDto) {
    const { email, password } = credentials;

    const user = await this.findByEmailOrFail(email);
    const isPasswordValid = await comparePassword(password, user.password);
    if (!isPasswordValid)
      throw new UnauthorizedException('Invalid credentials');

    const token = this.jwtService.sign(
      {
        id: user.id,
        name: user.name,
        email: user.email,
      },
      {
        expiresIn: '1d',
      },
    );

    const refreshToken = this.jwtService.sign(
      { id: user.id },
      {
        expiresIn: '7d',
      },
    );

    return { token, refreshToken };
  }
}
