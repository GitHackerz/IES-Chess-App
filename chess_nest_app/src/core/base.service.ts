import { Document, Model } from 'mongoose';
import { NotFoundException } from '@nestjs/common';

export class BaseService<T extends Document, CreateDTO, UpdateDTO> {
  constructor(private readonly model: Model<T>) {}

  create(createDto: CreateDTO): Promise<T> {
    const createdEntity = new this.model(createDto);
    return createdEntity.save();
  }

  findAll(): Promise<T[]> {
    return this.model.find();
  }

  findById(id: string): Promise<T> {
    return this.model.findById(id);
  }

  findByIdOrFail(id: string): Promise<T> {
    return this.model
      .findById(id)
      .orFail(
        new NotFoundException(this.model.modelName || 'Enitty' + ' not found'),
      );
  }

  findOne(conditions: any): Promise<T> {
    return this.model.findOne(conditions);
  }

  findOneOrFail(conditions: any): Promise<T> {
    return this.model
      .findOne(conditions)
      .orFail(
        new NotFoundException(this.model.modelName || 'Enitty' + ' not found'),
      );
  }

  update(id: string, updateDto: UpdateDTO): Promise<T> {
    return this.model
      .findByIdAndUpdate(id, updateDto, { new: true })
      .orFail(
        new NotFoundException(this.model.modelName || 'Enitty' + ' not found'),
      );
  }

  delete(id: string): Promise<T> {
    return this.model
      .findByIdAndDelete(id)
      .orFail(
        new NotFoundException(this.model.modelName || 'Enitty' + ' not found'),
      );
  }
}
